; ---------------------------------------------------------------------------
; Object 0E - Sonic on the title screen

; spawned by:
;	GM_Title
; ---------------------------------------------------------------------------

TitleSonic:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	TSon_Index(pc,d0.w),d1
		jmp	TSon_Index(pc,d1.w)
; ===========================================================================
TSon_Index:	index *,,2
		ptr TSon_Main
		ptr TSon_Delay
		ptr TSon_Move
		ptr TSon_Animate

TSon_Settings:	dc.b ost_routine,2
		dc.b -3,ost_x_pos
		dc.l $F00000+150+40
		dc.b -3,ost_mappings
		dc.l Map_TSon
		dc.b -2,ost_tile
		dc.w (vram_title_sonic/sizeof_cell)+tile_pal2
		dc.b ost_priority,1
		dc.b ost_anim_delay,29
		dc.b -1
		even
; ===========================================================================

TSon_Main:	; Routine 0
		lea	TSon_Settings(pc),a2
		bsr.w	SetupObject
		lea	(Ani_TSon).l,a1
		bsr.w	AnimateSprite

TSon_Delay:	;Routine 2
		subq.b	#1,ost_anim_delay(a0)			; decrement timer
		bpl.s	@wait					; if time remains, branch
		addq.b	#2,ost_routine(a0)			; goto TSon_Move next
		bra.s	TSon_display

	@wait:
		rts	
; ===========================================================================

TSon_Move:	; Routine 4
		subq.w	#8,ost_y_screen(a0)			; move Sonic up
		cmpi.w	#150,ost_y_screen(a0)			; has Sonic reached final position?
		bne.s	TSon_display				; if not, branch
		addq.b	#2,ost_routine(a0)			; goto TSon_Animate next

	TSon_display:
		bra.w	DisplaySprite
; ===========================================================================

TSon_Animate:	; Routine 6
		lea	(Ani_TSon).l,a1
		bsr.w	AnimateSprite
		bra.s	TSon_display

; ---------------------------------------------------------------------------
; Animation script
; ---------------------------------------------------------------------------

Ani_TSon:	index *
		ptr ani_tson_0
		
ani_tson_0:	dc.b 7
		dc.b id_frame_tson_0
		dc.b id_frame_tson_1
		dc.b id_frame_tson_2
		dc.b id_frame_tson_3
		dc.b id_frame_tson_4
		dc.b id_frame_tson_5
		dc.b id_frame_tson_wag1
		dc.b id_frame_tson_wag2
		dc.b afBack, 2
		even
