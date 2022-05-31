; ---------------------------------------------------------------------------
; Object 89 - "SONIC THE HEDGEHOG" text	on the ending sequence

; spawned by:
;	EndSonic
; ---------------------------------------------------------------------------

EndSTH:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	ESth_Index(pc,d0.w),d1
		jsr	ESth_Index(pc,d1.w)
		jmp	(DisplaySprite).l
; ===========================================================================
ESth_Index:	index *,,2
		ptr ESth_Main
		ptr ESth_Move
		ptr ESth_GotoCredits

ost_esth_wait_time:	equ $30					; time until exit (2 bytes)

EStH_Settings:	dc.b ost_routine,2
		dc.b so_write_long,ost_x_pos
		dc.l $FFE000D8
		dc.b so_write_long,ost_mappings
		dc.l Map_ESTH
		dc.b so_write_word,ost_tile
		dc.w tile_Nem_EndStH
		dc.b ost_render,render_abs
		dc.b so_write_word,ost_esth_wait_time
		dc.w 300
		dc.b so_end
		even
; ===========================================================================

ESth_Main:	; Routine 0
		lea	EStH_Settings(pc),a2
		jsr	SetupObject

ESth_Move:	; Routine 2
		cmpi.w	#$C0,ost_x_pos(a0)			; has object reached $C0?
		beq.s	@at_target				; if yes, branch
		addi.w	#$10,ost_x_pos(a0)			; move object to the right
		rts

@at_target:
		addq.b	#2,ost_routine(a0)			; goto ESth_GotoCredits next

ESth_GotoCredits:
		; Routine 4
		subq.w	#1,ost_esth_wait_time(a0)		; subtract 1 from duration
		bpl.s	@wait					; branch if time remains
		move.b	#id_Credits,(v_gamemode).w		; exit to credits

	@wait:
		rts
