; ---------------------------------------------------------------------------
; Object 62 - gargoyle head (LZ)

; spawned by:
;	ObjPos_LZ1, ObjPos_LZ2, ObjPos_LZ3, ObjPos_SBZ3 - subtypes 1/2/3/4
;	Gargoyle - subtype 0; routine 4 (fireball)
; ---------------------------------------------------------------------------

Gargoyle:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	Gar_Index(pc,d0.w),d1
		jsr	Gar_Index(pc,d1.w)
		bra.w	DespawnObject
; ===========================================================================
Gar_Index:	index *,,2
		ptr Gar_Main
		ptr Gar_MakeFire
		ptr Gar_FireBall
		ptr Gar_AniFire

Gar_Settings:	dc.b ost_routine,2
		dc.b so_write_long,ost_mappings
		dc.l Map_Gar
		dc.b so_write_word,ost_tile
		dc.w $2CE+tile_pal3
		dc.b ost_priority,3
		dc.b ost_actwidth,16
		dc.b so_render_rel
		dc.b so_end
		even
Gar_Settings2:	dc.b ost_id,id_Gargoyle
		dc.b ost_routine,id_Gar_FireBall
		dc.b so_inherit_word,ost_x_pos
		dc.b so_inherit_word,ost_y_pos
		dc.b so_inherit_byte,ost_render
		dc.b so_inherit_byte,ost_status
		dc.b so_end
		even
; ===========================================================================

Gar_Main:	; Routine 0
		lea	Gar_Settings(pc),a2
		bsr.w	SetupObject
		move.b	ost_subtype(a0),d0			; get object type
		mulu.w	#30,d0
		move.b	d0,ost_anim_delay(a0)			; set fireball spit rate
		move.b	ost_anim_delay(a0),ost_anim_time(a0)

Gar_MakeFire:	; Routine 2
		subq.b	#1,ost_anim_time(a0)			; decrement timer
		bne.s	@nofire					; if time remains, branch

		move.b	ost_anim_delay(a0),ost_anim_time(a0)	; reset timer
		bsr.w	CheckOffScreen
		bne.s	@nofire					; branch if off screen
		bsr.w	FindFreeObj				; find free OST slot
		bne.s	@nofire					; branch if not found
		lea	Gar_Settings2(pc),a2
		bsr.w	SetupChild

	@nofire:
		rts	
; ===========================================================================

GarF_Settings:	dc.b ost_routine,id_Gar_AniFire
		dc.b so_write_long,ost_mappings
		dc.l Map_GarFire
		dc.b so_write_word,ost_tile
		dc.w $2CE
		dc.b ost_priority,4
		dc.b ost_actwidth,8
		dc.b ost_col_type,id_col_4x4+id_col_hurt
		dc.b so_write_word,ost_x_vel
		dc.w $200
		dc.b so_render_rel
		dc.b so_end
		even

Gar_FireBall:	; Routine 4
		lea	GarF_Settings(pc),a2
		bsr.w	SetupObject
		addq.w	#8,ost_y_pos(a0)
		btst	#status_xflip_bit,ost_status(a0)	; is gargoyle facing left?
		bne.s	@noflip					; if not, branch
		neg.w	ost_x_vel(a0)				; move fireball left

	@noflip:
		play.w	1, jsr, sfx_FireBall			; play fireball sound

Gar_AniFire:	; Routine 6
		move.b	(v_frame_counter_low).w,d0
		andi.b	#7,d0
		bne.s	@nochg
		bchg	#0,ost_frame(a0)			; change frame every 8 frames

	@nochg:
		bsr.w	SpeedToPos				; update position
		btst	#status_xflip_bit,ost_status(a0)	; is fireball moving left?
		bne.s	@isright				; if not, branch
		moveq	#-8,d3
		bsr.w	FindWallLeftObj
		tst.w	d1
		bmi.w	DeleteObject				; delete if the	fireball hits a	wall to the left
		rts	

	@isright:
		moveq	#8,d3
		bsr.w	FindWallRightObj
		tst.w	d1
		bmi.w	DeleteObject				; delete if the	fireball hits a	wall to the right
		rts	
