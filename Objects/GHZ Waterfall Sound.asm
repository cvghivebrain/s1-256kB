; ---------------------------------------------------------------------------
; Object 49 - waterfall	sound effect (GHZ)

; spawned by:
;	ObjPos_GHZ1, ObjPos_GHZ2, ObjPos_GHZ3
; ---------------------------------------------------------------------------

WaterSound:
		moveq	#0,d0
		move.b	#render_rel,ost_render(a0)
		move.b	(v_vblank_counter_byte).w,d0		; get low byte of VBlank counter
		andi.b	#$3F,d0					; read bits 0-5
		bne.s	@skip_sfx				; branch if not 0
		play.w	1, jsr, sfx_Waterfall			; play waterfall sound (every 64 frames)

	@skip_sfx:
		out_of_range	DeleteObject
		rts	
