; ---------------------------------------------------------------------------
; Object 44 - edge walls (GHZ)

; spawned by:
;	ObjPos_GHZ1, ObjPos_GHZ2, ObjPos_GHZ3 - subtypes 0/1/2/$10/$11/$12
; ---------------------------------------------------------------------------

EdgeWalls:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	Edge_Index(pc,d0.w),d1
		jmp	Edge_Index(pc,d1.w)
; ===========================================================================
Edge_Index:	index *,,2
		ptr Edge_Main
		ptr Edge_Solid
		ptr Edge_Display

Edge_Settings:	dc.b ost_routine,2
		dc.b so_write_long,ost_mappings
		dc.l Map_Edge
		dc.b so_write_word,ost_tile
		dc.w $332+tile_pal3
		dc.b ost_actwidth,8
		dc.b ost_priority,6
		dc.b so_copy_byte,ost_subtype,ost_frame
		dc.b so_render_rel
		dc.b so_end
		even
; ===========================================================================

Edge_Main:	; Routine 0
		lea	Edge_Settings(pc),a2
		bsr.w	SetupObject
		bclr	#4,ost_frame(a0)			; clear 4th bit (deduct $10)
		beq.s	Edge_Solid				; branch if already clear (subtype 0/1/2 is solid)

		addq.b	#2,ost_routine(a0)			; goto Edge_Display next
		bra.s	Edge_Display				; bit 4 was already set (subtype $10/$11/$12 is not solid)
; ===========================================================================

Edge_Solid:	; Routine 2
		move.w	#$13,d1					; width
		move.w	#$28,d2					; height
		move.w	#$28,d3
		move.w	ost_x_pos(a0),d4
		bsr.w	SolidObject

Edge_Display:	; Routine 4
		bsr.w	DisplaySprite
		out_of_range	DeleteObject
		rts
