; ---------------------------------------------------------------------------
; Object 48 - ball on a	chain that Eggman swings (GHZ)

; spawned by:
;	BossGreenHill - routine 0
;	BossBall - routines 6 (chain), 8 (ball)
; ---------------------------------------------------------------------------

include_BossBall_1:	macro

BossBall:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	GBall_Index(pc,d0.w),d1
		jmp	GBall_Index(pc,d1.w)
; ===========================================================================
GBall_Index:	index *,,2
		ptr GBall_Main
		ptr GBall_Base
		ptr GBall_Base2
		ptr GBall_Link
		ptr GBall_Ball

ost_ball_boss_dist:	equ $32					; distance of base from boss (2 bytes)
ost_ball_parent:	equ $34					; address of OST of parent object (4 bytes)
ost_ball_base_y_pos:	equ $38					; y position of base (2 bytes)
ost_ball_base_x_pos:	equ $3A					; x position of base (2 bytes)
ost_ball_radius:	equ $3C					; distance of ball/link from base
ost_ball_side:		equ $3D					; which side the ball is on - 0 = right; 1 = left
ost_ball_speed:		equ $3E					; rate of change of angle (2 bytes)

GBall_Settings:	dc.b ost_routine,2
		dc.b so_write_word,ost_angle
		dc.w $4080
		dc.b so_write_word,ost_ball_speed
		dc.w -$200
		dc.b so_write_long,ost_mappings
		dc.l Map_BossItems
		dc.b so_write_word,ost_tile
		dc.w tile_Nem_Weapons
		dc.b so_end
		even
GBall_Settings2:
		dc.b so_inherit_word,ost_x_pos
		dc.b so_inherit_word,ost_y_pos
		dc.b ost_id,id_BossBall
		dc.b ost_routine,id_GBall_Link
		dc.b so_write_long,ost_mappings
		dc.l Map_Swing_GHZ
		dc.b so_write_word,ost_tile
		dc.w $6B0
		dc.b ost_frame,id_frame_swing_chain
		dc.b so_end
		even
GBall_Settings3:
		dc.b ost_routine,id_GBall_Ball
		dc.b so_write_long,ost_mappings
		dc.l Map_GBall
		dc.b so_write_word,ost_tile
		dc.w $3A0+tile_pal3
		dc.b ost_frame,id_frame_ball_check1
		dc.b ost_priority,5
		dc.b ost_col_type,id_col_20x20+id_col_hurt
		dc.b so_end
		even
; ===========================================================================

GBall_Main:	; Routine 0
		lea	GBall_Settings(pc),a2
		bsr.w	SetupObject
		lea	ost_subtype(a0),a3
		move.b	#0,(a3)+
		moveq	#5,d2					; load 5 additional objects
		movea.l	a0,a1					; replace current object with chain base
		bra.s	@chain_base
; ===========================================================================

	@loop:
		jsr	(FindNextFreeObj).l			; find free OST slot
		bne.s	@fail					; branch if not found
		lea	GBall_Settings2(pc),a2
		bsr.w	SetupChild
		addq.b	#1,ost_subtype(a0)			; increment parent's subtype (ends up being 5)

@chain_base:
		move.w	a1,d5					; address of current OST
		subi.w	#v_ost_all&$FFFF,d5
		lsr.w	#6,d5
		andi.w	#$7F,d5					; convert address to OST index
		move.b	d5,(a3)+				; add to list in parent OST
		move.b	#render_rel,ost_render(a1)
		move.b	#8,ost_actwidth(a1)
		move.b	#6,ost_priority(a1)
		move.l	ost_ball_parent(a0),ost_ball_parent(a1)
		dbf	d2,@loop				; repeat sequence 5 more times

	@fail:
		lea	GBall_Settings3(pc),a2
		bsr.w	SetupChild
		rts	
; ===========================================================================

GBall_PosData:	; distances of objects from base
		dc.b 0						; base
		dc.b $10, $20, $30, $40				; chain links
		dc.b $60					; ball

; ===========================================================================

GBall_Base:	; Routine 2
		lea	(GBall_PosData).l,a3
		lea	ost_subtype(a0),a2
		moveq	#0,d6
		move.b	(a2)+,d6				; get number of child objects

	@loop:
		moveq	#0,d4
		move.b	(a2)+,d4				; get child object OST index
		lsl.w	#6,d4
		addi.l	#v_ost_all&$FFFFFF,d4
		movea.l	d4,a1					; convert to RAM address
		move.b	(a3)+,d0				; get target distance from base
		cmp.b	ost_ball_radius(a1),d0			; has object reached target?
		beq.s	@reached_dist				; if yes, branch
		addq.b	#1,ost_ball_radius(a1)			; increment distance

	@reached_dist:
		dbf	d6,@loop				; repeat for all children

		cmp.b	ost_ball_radius(a1),d0			; has final object (ball) reached target?
		bne.s	@not_finished				; if not, branch
		movea.l	ost_ball_parent(a0),a1
		cmpi.b	#id_BGHZ_ChgDir,ost_routine2(a1)	; is boss in back-and-forth phase?
		bne.s	@not_finished				; if not, branch
		addq.b	#2,ost_routine(a0)			; goto GBall_Base2 next

	@not_finished:
		cmpi.w	#$20,ost_ball_boss_dist(a0)		; has base moved an additional 32px? (aligned with bottom of ship)
		beq.s	@reached_dist2				; if yes, branch
		addq.w	#1,ost_ball_boss_dist(a0)		; increment distance

	@reached_dist2:
		bsr.w	GBall_UpdateBase			; update base animation/position
		move.b	ost_angle(a0),d0
		jsr	(Swing_MoveAll).l			; update positions of all chain links & ball
		bra.s	GBall_Ball_display
; ===========================================================================

GBall_Base2:	; Routine 4
		bsr.w	GBall_UpdateBase			; update base animation/position
		jsr	(GBall_Move).l				; update angle and positions of child objects
		bra.s	GBall_Ball_display

; ---------------------------------------------------------------------------
; Subroutine to animate, update position and destroy base
; ---------------------------------------------------------------------------

GBall_UpdateBase:
		movea.l	ost_ball_parent(a0),a1			; get address of OST of parent
		addi.b	#$20,ost_anim_frame(a0)			; increment frame counter
		bcc.s	@no_chg					; branch if byte doesn't wrap from $C0 to 0
		bchg	#0,ost_frame(a0)			; change frame every 8th frame

	@no_chg:
		move.w	ost_x_pos(a1),ost_ball_base_x_pos(a0)	; get position from parent (ship)
		move.w	ost_y_pos(a1),d0
		add.w	ost_ball_boss_dist(a0),d0
		move.w	d0,ost_ball_base_y_pos(a0)
		move.b	ost_status(a1),ost_status(a0)
		tst.b	ost_status(a1)				; has boss been beaten?
		bpl.s	@not_beaten				; if not, branch
		move.b	#id_ExplosionBomb,ost_id(a0)		; replace base with explosion object
		move.b	#id_ExBom_Main,ost_routine(a0)

	@not_beaten:
		rts	
; End of function GBall_UpdateBase

; ===========================================================================

GBall_Link:	; Routine 6
		movea.l	ost_ball_parent(a0),a1			; get address of OST of parent (ship)
		tst.b	ost_status(a1)				; has boss been beaten?
		bpl.s	@not_beaten				; if not, branch
		move.b	#id_ExplosionBomb,ost_id(a0)		; replace chain with explosion object
		move.b	#id_ExBom_Main,ost_routine(a0)

	@not_beaten:
GBall_Ball_display:
		jmp	(DisplaySprite).l
; ===========================================================================

GBall_Ball:	; Routine 8
		bchg	#0,ost_frame(a0)			; use frame 0 or 1
		movea.l	ost_ball_parent(a0),a1			; get address of OST of parent (ship)
		tst.b	ost_status(a1)				; has boss been beaten?
		bpl.s	GBall_Ball_display				; if not, branch
		move.b	#0,ost_col_type(a0)			; make ball harmless
		bsr.w	BossExplode				; spawn explosions
		subq.b	#1,ost_ball_radius(a0)			; use radius as timer, decrements from 96
		bpl.s	GBall_Ball_display				; branch if time remains
		move.b	#id_ExplosionBomb,(a0)			; replace ball with explosion after 1.5 seconds
		move.b	#id_ExBom_Main,ost_routine(a0)
		rts

		endm
		
; ---------------------------------------------------------------------------
; Object 48 - ball on a	chain that Eggman swings (GHZ), part 2
; ---------------------------------------------------------------------------

include_BossBall_2:	macro

; ---------------------------------------------------------------------------
; Subroutine to update swinging angle and positions for chain links and ball
; ---------------------------------------------------------------------------

GBall_Move:
		tst.b	ost_ball_side(a0)			; is ball on the left side of the screen?
		bne.s	@left_side				; if yes, branch
		move.w	ost_ball_speed(a0),d0
		addq.w	#8,d0
		move.w	d0,ost_ball_speed(a0)			; increase swing speed
		add.w	d0,ost_angle(a0)			; update angle
		cmpi.w	#$200,d0				; is speed at max?
		bne.s	@not_at_highest				; if not, branch
		move.b	#1,ost_ball_side(a0)			; switch side flag
		bra.s	@not_at_highest
; ===========================================================================

	@left_side:
		move.w	ost_ball_speed(a0),d0
		subq.w	#8,d0
		move.w	d0,ost_ball_speed(a0)			; decrease swing speed
		add.w	d0,ost_angle(a0)			; update angle
		cmpi.w	#-$200,d0				; is speed at max?
		bne.s	@not_at_highest				; if not, branch
		move.b	#0,ost_ball_side(a0)			; switch side flag

	@not_at_highest:
		move.b	ost_angle(a0),d0			; get latest angle

		;bra.w	Swing_MoveAll				; runs directly into Swing_MoveAll (update positions of all objects)

; End of function GBall_Move

		endm
		
