; ---------------------------------------------------------------------------
; Object 3B - purple rock (GHZ)

; spawned by:
;	ObjPos_GHZ1, ObjPos_GHZ2, ObjPos_GHZ3
; ---------------------------------------------------------------------------

PurpleRock:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	Rock_Index(pc,d0.w),d1
		jmp	Rock_Index(pc,d1.w)
; ===========================================================================
Rock_Index:	index *,,2
		ptr Rock_Main
		ptr Rock_Solid

Rock_Settings:	dc.b ost_routine,2
		dc.b so_write_long,ost_mappings
		dc.l Map_PRock
		dc.b so_write_word,ost_tile
		dc.w $3B4+tile_pal4
		dc.b ost_render,render_rel
		dc.b ost_actwidth,$13
		dc.b ost_priority,4
		dc.b so_end
		even
; ===========================================================================

Rock_Main:	; Routine 0
		lea	Rock_Settings(pc),a2
		bsr.w	SetupObject

Rock_Solid:	; Routine 2
		move.w	#$1B,d1					; width
		move.w	#$10,d2					; height
		move.w	#$10,d3					; height
		move.w	ost_x_pos(a0),d4
		bsr.w	SolidObject
		bsr.w	DisplaySprite
		out_of_range	DeleteObject
		rts	
