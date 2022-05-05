; ---------------------------------------------------------------------------
; Subroutine to	clear the screen
; Deletes fg/bg nametables and sprite/hscroll buffers

; input:
;	a5 = vdp_control_port ($C00004)

;	uses d0, d1, a1
; ---------------------------------------------------------------------------

ClearScreen:
		dma_fill	0,sizeof_vram_fg-1,vram_fg	; clear foreground nametable

	@wait_for_dma:
		move.w	(a5),d1					; get status register (a5 = vdp_control_port)
		btst	#1,d1					; is DMA in progress?
		bne.s	@wait_for_dma				; if yes, branch

		move.w	#$8F02,(a5)				; set VDP increment 2 bytes
		dma_fill	0,sizeof_vram_bg-1,vram_bg	; clear background nametable

	@wait_for_dma2:
		move.w	(a5),d1
		btst	#1,d1
		bne.s	@wait_for_dma2

		move.w	#$8F02,(a5)				; set VDP increment 2 bytes
		clr.l	(v_fg_y_pos_vsram).w
		clr.l	(v_fg_x_pos_hscroll).w

		move.l	#(v_sprite_buffer&$FFFF)+(((($280)/4)-1)<<16),d0
		bsr.w	ClearRAM

ClearScreen_hscroll:
		move.l	#(v_hscroll_buffer&$FFFF)+(((($400)/4)-1)<<16),d0
		bsr.w	ClearRAM
		rts
