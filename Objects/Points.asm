; ---------------------------------------------------------------------------
; Object 29 - points that appear when you destroy something

; spawned by:
;	Animals, SmashBlock, Bumper
; ---------------------------------------------------------------------------

Points:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	Poi_Index(pc,d0.w),d1
		jsr	Poi_Index(pc,d1.w)
		bra.w	DisplaySprite
; ===========================================================================
Poi_Index:	index *,,2
		ptr Poi_Main
		ptr Poi_Slower

Poi_Settings:	dc.b ost_routine,2
		dc.b so_write_long,ost_mappings
		dc.l Map_Points
		dc.b so_write_word,ost_tile
		dc.w ($F2E0/sizeof_cell)+tile_pal2
		dc.b ost_render,render_rel
		dc.b ost_priority,1
		dc.b ost_actwidth,8
		dc.b so_write_word,ost_y_vel
		dc.w -$300
		dc.b so_end
		even
; ===========================================================================

Poi_Main:	; Routine 0
		lea	Poi_Settings(pc),a2
		bsr.w	SetupObject

Poi_Slower:	; Routine 2
		tst.w	ost_y_vel(a0)				; is object moving?
		bpl.w	DeleteObject				; if not, delete
		bsr.w	SpeedToPos				; update position
		addi.w	#$18,ost_y_vel(a0)			; reduce object speed
		rts	
