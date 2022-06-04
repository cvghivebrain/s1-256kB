; ---------------------------------------------------------------------------
; Object 7F - chaos emeralds from the special stage results screen

; spawned by:
;	SSResult, SSRChaos
; ---------------------------------------------------------------------------

SSRChaos:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	SSRC_Index(pc,d0.w),d1
		jmp	SSRC_Index(pc,d1.w)
; ===========================================================================
SSRC_Index:	index *,,2
		ptr SSRC_Main
		ptr SSRC_Flash

SSRC_PosData:	; x positions for chaos emeralds
		dc.w $110					; blue
		dc.w $128					; yellow
		dc.w $F8					; pink
		dc.w $140					; green
		dc.w $E0					; red
		dc.w $158					; grey

SSRC_Settings:	dc.b ost_id,id_SSRChaos
		dc.b so_write_word,ost_y_screen
		dc.w $F0
		dc.b so_write_long,ost_mappings
		dc.l Map_SSRC
		dc.b so_write_word,ost_tile
		dc.w tile_Nem_ResultEm+tile_hi
		dc.b ost_routine,id_SSRC_Flash
		dc.b so_end
		even
; ===========================================================================

SSRC_Main:	; Routine 0
		movea.l	a0,a1					; replace current object with 1st emerald
		lea	(SSRC_PosData).l,a4
		moveq	#0,d2
		moveq	#0,d4
		move.b	(v_emeralds).w,d4			; get number of emeralds
		subq.b	#1,d4					; subtract 1 for number of loops
		bcs.w	DeleteObject				; if you have 0	emeralds, branch

	@loop:
		lea	SSRC_Settings(pc),a2
		bsr.w	SetupChild
		move.w	(a4)+,ost_x_pos(a1)			; set x position from list
		lea	(v_emerald_list).w,a3			; get list of individual emeralds (numbered 0 to 5)
		move.b	(a3,d2.w),d3				; read value of current emerald
		move.b	d3,ost_frame(a1)			; set frame number
		move.b	d3,ost_anim(a1)				; copy frame number (not an animation number)
		addq.b	#1,d2					; next emerald value
		lea	sizeof_ost(a1),a1			; next object
		dbf	d4,@loop				; repeat for rest of emeralds

SSRC_Flash:	; Routine 2
		move.b	ost_frame(a0),d0			; get previous frame
		move.b	#id_frame_ssrc_blank,ost_frame(a0)	; use blank frame (6)
		cmpi.b	#id_frame_ssrc_blank,d0			; was previous frame blank?
		bne.s	@keep_frame				; if not, branch
		move.b	ost_anim(a0),ost_frame(a0)		; use original frame stored in ost_anim

	@keep_frame:
		bra.w	DisplaySprite
