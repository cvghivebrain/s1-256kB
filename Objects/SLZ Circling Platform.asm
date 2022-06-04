; ---------------------------------------------------------------------------
; Object 5A - platforms	moving in circles (SLZ)

; spawned by:
;	ObjPos_SLZ1, ObjPos_SLZ2, ObjPos_SLZ3 - subtypes 0-7
; ---------------------------------------------------------------------------

CirclingPlatform:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	Circ_Index(pc,d0.w),d1
		jsr	Circ_Index(pc,d1.w)
		out_of_range	DeleteObject,ost_circ_x_start(a0)
		bra.w	DisplaySprite
; ===========================================================================
Circ_Index:	index *,,2
		ptr Circ_Main
		ptr Circ_Platform
		ptr Circ_StoodOn

ost_circ_y_start:	equ $30					; original y-axis position (2 bytes)
ost_circ_x_start:	equ $32					; original x-axis position (2 bytes)

Circ_Settings:	dc.b ost_routine,2
		dc.b so_write_long,ost_mappings
		dc.l Map_Circ
		dc.b so_write_word,ost_tile
		dc.w 0+tile_pal3
		dc.b ost_render,render_rel
		dc.b ost_priority,4
		dc.b ost_actwidth,$18
		dc.b so_copy_word,ost_x_pos,ost_circ_x_start
		dc.b so_copy_word,ost_y_pos,ost_circ_y_start
		dc.b so_end
		even
; ===========================================================================

Circ_Main:	; Routine 0
		lea	Circ_Settings(pc),a2
		bsr.w	SetupObject

Circ_Platform:	; Routine 2
		moveq	#0,d1
		move.b	ost_actwidth(a0),d1
		jsr	(DetectPlatform).l			; detect collision and goto Circ_StoodOn next if true
		bra.w	Circ_Types
; ===========================================================================

Circ_StoodOn:	; Routine 4
		moveq	#0,d1
		move.b	ost_actwidth(a0),d1
		jsr	(ExitPlatform).l			; goto Circ_Platform next if Sonic leaves platform
		move.w	ost_x_pos(a0),-(sp)
		bsr.w	Circ_Types
		move.w	(sp)+,d2
		jmp	(MoveWithPlatform2).l			; update Sonic's position
; ===========================================================================

Circ_Types:
Circ_Clockwise:
		move.b	(v_oscillating_table+$20).w,d1
		subi.b	#$50,d1
		ext.w	d1
		move.b	(v_oscillating_table+$24).w,d2
		subi.b	#$50,d2
		ext.w	d2
		btst	#0,ost_subtype(a0)
		beq.s	@not_1_or_3
		neg.w	d1
		neg.w	d2

	@not_1_or_3:
		btst	#1,ost_subtype(a0)
		beq.s	@not_2_or_3
		neg.w	d1
		exg	d1,d2

	@not_2_or_3:
		btst	#2,ost_subtype(a0)
		beq.s	@anticlockwise
		neg.w	d1					; reverse x position delta

	@anticlockwise:
		add.w	ost_circ_x_start(a0),d1
		move.w	d1,ost_x_pos(a0)
		add.w	ost_circ_y_start(a0),d2
		move.w	d2,ost_y_pos(a0)
		rts	
