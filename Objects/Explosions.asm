; ---------------------------------------------------------------------------
; Object 27 - explosion	from a destroyed enemy or monitor

; spawned by:
;	ReactToItem - routine 0
;	Monitor - routine 2
; ---------------------------------------------------------------------------

ExplosionItem:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	ExItem_Index(pc,d0.w),d1
		jmp	ExItem_Index(pc,d1.w)
; ===========================================================================
ExItem_Index:	index *,,2
		ptr ExItem_Animal
		ptr ExItem_Main
		ptr ExItem_Animate

Ex_Settings:	dc.b so_write_long,ost_mappings
		dc.l Map_ExplodeItem
		dc.b so_write_word,ost_tile
		dc.w tile_Nem_Explode
		dc.b ost_render,render_rel
		dc.b ost_priority,1
		dc.b ost_col_type,0
		dc.b ost_actwidth,12
		dc.b ost_anim_time,7
		dc.b so_end
		even

Ex_Settings2:	dc.b ost_id,id_Animals
		dc.b so_inherit_word,ost_x_pos
		dc.b so_inherit_word,ost_y_pos
		dc.b so_inherit_byte,ost_enemy_combo
		dc.b so_end
		even
; ===========================================================================

ExItem_Animal:	; Routine 0
		addq.b	#2,ost_routine(a0)			; goto ExItem_Main next
		bsr.w	FindFreeObj				; find free OST slot
		bne.s	ExItem_Main				; branch if none found
		lea	Ex_Settings2(pc),a2
		bsr.w	SetupChild

ExItem_Main:	; Routine 2
		addq.b	#2,ost_routine(a0)			; goto ExItem_Animate next
		lea	Ex_Settings(pc),a2
		bsr.w	SetupObject
		move.b	#id_frame_ex_0,ost_frame(a0)
		play.w	1, jsr, sfx_Break			; play breaking enemy sound

ExItem_Animate:	; Routine 4 (2 for ExplosionBomb)
ExBom_Animate:
		subq.b	#1,ost_anim_time(a0)			; subtract 1 from frame duration
		bpl.s	@display
		move.b	#7,ost_anim_time(a0)			; set frame duration to 7 frames
		addq.b	#1,ost_frame(a0)			; next frame
		cmpi.b	#5,ost_frame(a0)			; is the final frame (05) displayed?
		beq.w	DeleteObject				; if yes, branch

	@display:
		bra.w	DisplaySprite

; ---------------------------------------------------------------------------
; Object 3F - explosion	from a destroyed boss, bomb or cannonball

; spawned by:
;	Cannonball, Bomb, BossPlasma, BossBall, BossSpikeball, BossExplode, Prison
; ---------------------------------------------------------------------------

ExplosionBomb:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	ExBom_Index(pc,d0.w),d1
		jmp	ExBom_Index(pc,d1.w)
; ===========================================================================
ExBom_Index:	index *,,2
		ptr ExBom_Main
		ptr ExBom_Animate
; ===========================================================================

ExBom_Main:	; Routine 0
		addq.b	#2,ost_routine(a0)			; goto ExBom_Animate next
		lea	Ex_Settings(pc),a2
		bsr.w	SetupObject
		move.l	#Map_ExplodeBomb,ost_mappings(a0)
		move.b	#id_frame_ex_0_0,ost_frame(a0)
		play.w	1, jmp, sfx_Bomb			; play exploding bomb sound
