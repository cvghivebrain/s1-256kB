; ---------------------------------------------------------------------------
; Object 8A - "SONIC TEAM PRESENTS" and	credits

; spawned by:
;	GM_Title, GM_Credits, EndEggman
; ---------------------------------------------------------------------------

CreditsText:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	Cred_Index(pc,d0.w),d1
		jmp	Cred_Index(pc,d1.w)
; ===========================================================================
Cred_Index:	index *,,2
		ptr Cred_Main
		ptr Cred_Display

Cred_Settings:	dc.b ost_routine,2
		dc.b so_write_long,ost_x_pos
		dc.l $12000F0
		dc.b so_write_word,ost_tile
		dc.w tile_Nem_CreditText
		dc.b so_write_long,ost_mappings
		dc.l Map_Cred
		dc.b ost_render,render_abs
		dc.b so_end
		even
; ===========================================================================

Cred_Main:	; Routine 0
		lea	Cred_Settings(pc),a2
		bsr.w	SetupObject
		move.w	(v_credits_num).w,d0			; load credits index number
		move.b	d0,ost_frame(a0)			; display appropriate sprite

		cmpi.b	#id_Title,(v_gamemode).w		; is the mode #4 (title screen)?
		bne.s	Cred_Display				; if not, branch

		move.w	#vram_title_credits/sizeof_cell,ost_tile(a0)
		move.b	#id_frame_cred_sonicteam,ost_frame(a0)	; display "SONIC TEAM PRESENTS"

Cred_Display:	; Routine 2
		cmpi.b	#id_TitleSonic,(v_ost_titlesonic).w
		bne.s	@display
		jmp	DeleteObject
	@display:
		jmp	DisplaySprite
