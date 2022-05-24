; ---------------------------------------------------------------------------
; Subroutine to set an object's initial OST values

; input:
;	a0 = address of OST of object
;	a2 = address of script
; ---------------------------------------------------------------------------

SetupObject:
		moveq	#0,d0
		
	@loop:
		move.b	(a2)+,d0				; get relative OST address or flag
		bmi.s	@flag					; branch if negative
		move.b	(a2)+,(a0,d0.w)				; write value to OST
		bra.s	@loop					; repeat until flag
		
	@flag:
		addq.b	#1,d0					; is flag -1?
		bne.s	@flag_fe				; if not, branch
		rts						; end of script
		
	@flag_fe:
		addq.b	#1,d0					; is flag -2?
		bne.s	@flag_fd				; if not, branch
		move.b	(a2)+,d0				; get relative OST address
		move.w	(a2)+,(a0,d0.w)				; write word value to OST
		bra.s	@loop					; repeat until flag
		
	@flag_fd:
		move.b	(a2)+,d0				; get relative OST address
		move.l	(a2)+,(a0,d0.w)				; write longword value to OST
		bra.s	@loop					; repeat until flag
		