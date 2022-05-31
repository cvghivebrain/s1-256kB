; ---------------------------------------------------------------------------
; Object 21 - SCORE, TIME, RINGS

; spawned by:
;	GM_Level, GM_Ending
; ---------------------------------------------------------------------------

HUD:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	HUD_Index(pc,d0.w),d1
		jmp	HUD_Index(pc,d1.w)
; ===========================================================================
HUD_Index:	index *
		ptr HUD_Main
		ptr HUD_Flash

HUD_Settings:	dc.b ost_routine,2
		dc.b so_write_long,ost_x_pos
		dc.l $900108
		dc.b so_write_long,ost_mappings
		dc.l Map_HUD
		dc.b so_write_word,ost_tile
		dc.w $D940/sizeof_cell
		dc.b ost_render,render_abs
		dc.b so_end
		even
; ===========================================================================

HUD_Main:	; Routine 0
		lea	HUD_Settings(pc),a2
		jsr	SetupObject

HUD_Flash:	; Routine 2
		tst.w	(v_rings).w				; do you have any rings?
		beq.s	@norings				; if not, branch
		clr.b	ost_frame(a0)				; make all counters yellow
		bra.s	@display2
; ===========================================================================

@norings:
		moveq	#0,d0
		btst	#3,(v_frame_counter_low).w		; check bit that changes every 8 frames
		bne.s	@display				; branch if set

		addq.w	#id_frame_hud_ringred,d0		; make ring counter flash red
		cmpi.b	#9,(v_time_min).w			; have 9 minutes elapsed?
		bne.s	@display				; if not, branch
		addq.w	#id_frame_hud_timered,d0		; make time counter flash red (only flashes if you also have no rings)

	@display:
		move.b	d0,ost_frame(a0)
	@display2:
		jmp	DisplaySprite
