; ---------------------------------------------------------------------------
; Subroutine to set an object's initial OST values

; input:
;	a0 = address of OST of object
;	a2 = address of script
; ---------------------------------------------------------------------------

so_end:			equ -2
so_write_word:		equ -4
so_write_long:		equ -6
so_copy_byte:		equ -8
so_copy_word:		equ -10
so_copy_long:		equ -12
so_inherit_byte:	equ -14
so_inherit_word:	equ -16
so_inherit_long:	equ -18
so_render_rel:		equ -20
so_set_parent:		equ -22

SetupChild:
		exg	a0,a1					; make child the primary object
		bsr.s	SetupObject				; run object script
		exg	a0,a1					; make parent the primary object
		rts

SetupObject:
		moveq	#0,d0
		moveq	#0,d1
		
	SO_Loop:
		move.b	(a2)+,d0				; get relative OST address or flag
		bmi.s	@flag					; branch if negative
		move.b	(a2)+,(a0,d0.w)				; write value to OST
		bra.s	SO_Loop					; repeat until flag
		
	@flag:
		neg.b	d0					; convert flag to positive
		move.w	SO_Index(pc,d0.w),d1
		jmp	SO_Index(pc,d1.w)

SO_Index:	index *,,2
		ptr @end
		ptr @end		; 2
		ptr @write_word		; 4
		ptr @write_long		; 6
		ptr @copy_byte		; 8
		ptr @copy_word		; 10
		ptr @copy_long		; 12
		ptr @inherit_byte	; 14
		ptr @inherit_word	; 16
		ptr @inherit_long	; 18
		ptr @render_rel		; 20
		ptr @set_parent		; 22
	
	@get_ost_pair:
		moveq	#0,d1
		move.b	(a2)+,d0				; get OST address source
		move.b	(a2)+,d1				; get OST address target

	@end:
		rts						; end of script
		
	@write_word:
		move.b	(a2)+,d0				; get relative OST address
		move.w	(a2)+,(a0,d0.w)				; write word value to OST
		bra.s	SO_Loop					; continue reading script
		
	@write_long:
		move.b	(a2)+,d0				; get relative OST address
		move.l	(a2)+,(a0,d0.w)				; write longword value to OST
		bra.s	SO_Loop					; continue reading script
		
	@copy_byte:
		bsr.s	@get_ost_pair
		move.b	(a0,d0.w),(a0,d1.w)			; write byte to OST
		bra.s	SO_Loop					; continue reading script
		
	@copy_word:
		bsr.s	@get_ost_pair
		move.w	(a0,d0.w),(a0,d1.w)			; write word to OST
		bra.s	SO_Loop					; continue reading script
		
	@copy_long:
		bsr.s	@get_ost_pair
		move.l	(a0,d0.w),(a0,d1.w)			; write longword to OST
		bra.s	SO_Loop					; continue reading script
		
	@inherit_byte:
		move.b	(a2)+,d0				; get OST address
		move.b	(a1,d0.w),(a0,d0.w)			; write byte to OST
		bra.s	SO_Loop					; continue reading script
		
	@inherit_word:
		move.b	(a2)+,d0				; get OST address
		move.w	(a1,d0.w),(a0,d0.w)			; write word to OST
		bra.s	SO_Loop					; continue reading script
		
	@inherit_long:
		move.b	(a2)+,d0				; get OST address
		move.l	(a1,d0.w),(a0,d0.w)			; write longword to OST
		bra.s	SO_Loop					; continue reading script
		
	@render_rel:
		ori.b	#render_rel,ost_render(a0)		; set render flag
		bra.w	SO_Loop					; continue reading script
		
	@set_parent:
		move.b	(a2)+,d0				; get OST address
		move.l	a1,(a0,d0.w)				; write longword to OST
		bra.w	SO_Loop					; continue reading script
		