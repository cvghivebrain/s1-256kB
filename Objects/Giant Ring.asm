; ---------------------------------------------------------------------------
; Object 4B - giant ring for entry to special stage

; spawned by:
;	ObjPos_GHZ1, ObjPos_GHZ2, ObjPos_MZ1, ObjPos_MZ2
;	ObjPos_SYZ1, ObjPos_SYZ2, ObjPos_LZ1, ObjPos_LZ2
;	ObjPos_SLZ1, ObjPos_SLZ2
; ---------------------------------------------------------------------------

GiantRing:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	GRing_Index(pc,d0.w),d1
		jmp	GRing_Index(pc,d1.w)
; ===========================================================================
GRing_Index:	index *,,2
		ptr GRing_Main
		ptr GRing_Animate
		ptr GRing_Collect
		ptr GRing_Delete

GRing_Settings:	dc.b so_write_long,ost_mappings
		dc.l Map_GRing
		dc.b so_write_word,ost_tile
		dc.w (vram_giantring/sizeof_cell)+tile_pal2
		dc.b ost_actwidth,$40
		dc.b ost_priority,2
		dc.b so_render_rel
		dc.b so_end
		even
; ===========================================================================

GRing_Main:	; Routine 0
		lea	GRing_Settings(pc),a2
		bsr.w	SetupObject
		tst.b	ost_render(a0)
		bpl.s	GRing_Animate
		cmpi.b	#6,(v_emeralds).w			; do you have 6 emeralds?
		beq.w	GRing_Delete				; if yes, branch
		cmpi.w	#50,(v_rings).w				; do you have at least 50 rings?
		bcc.s	GRing_Okay				; if yes, branch
		rts	
; ===========================================================================

GRing_Okay:
		addq.b	#2,ost_routine(a0)			; goto GRing_Animate next
		move.b	#id_col_8x16+id_col_item,ost_col_type(a0) ; when Sonic hits the item, goto GRing_Collect next (see ReactToItem)

GRing_Animate:	; Routine 2
		move.b	(v_syncani_1_frame).w,ost_frame(a0)
		out_of_range	DeleteObject
		bra.w	DisplaySprite
; ===========================================================================

GRing_Collect:	; Routine 4
		subq.b	#2,ost_routine(a0)			; goto GRing_Animate next
		move.b	#0,ost_col_type(a0)
		bsr.w	FindFreeObj				; find free OST slot
		bne.w	@fail					; branch if not found
		lea	GRing_Settings2(pc),a2
		bsr.w	SetupChild
		move.l	a0,ost_flash_parent(a1)
		move.w	(v_ost_player+ost_x_pos).w,d0
		cmp.w	ost_x_pos(a0),d0			; has Sonic come from the left?
		bcs.s	@noflip					; if yes, branch
		bset	#render_xflip_bit,ost_render(a1)	; reverse flash object

	@fail:
	@noflip:
		play.w	1, jsr, sfx_GiantRing			; play giant ring sound
		bra.s	GRing_Animate
; ===========================================================================

GRing_Delete:	; Routine 6
		bra.w	DeleteObject

GRing_Settings2:
		dc.b ost_id,id_RingFlash
		dc.b so_inherit_word,ost_x_pos
		dc.b so_inherit_word,ost_y_pos
		dc.b so_end
		even
