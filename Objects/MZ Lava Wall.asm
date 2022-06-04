; ---------------------------------------------------------------------------
; Object 4E - advancing	wall of	lava (MZ)

; spawned by:
;	ObjPos_MZ2 - subtype 0
;	LavaWall
; ---------------------------------------------------------------------------

LavaWall:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	LWall_Index(pc,d0.w),d1
		jmp	LWall_Index(pc,d1.w)
; ===========================================================================
LWall_Index:	index *,,2
		ptr LWall_Main
		ptr LWall_Solid
		ptr LWall_Action
		ptr LWall_BackHalf
		ptr LWall_Delete

ost_lwall_flag:		equ $36					; flag to start wall moving
ost_lwall_parent:	equ $3C					; address of OST of parent object (4 bytes)

LWall_Settings:	dc.b ost_id,id_LavaWall
		dc.b so_write_long,ost_mappings
		dc.l Map_LWall
		dc.b so_write_word,ost_tile
		dc.w $34A+tile_pal4
		dc.b ost_render,render_rel
		dc.b ost_actwidth,$50
		dc.b so_inherit_word,ost_x_pos
		dc.b so_inherit_word,ost_y_pos
		dc.b ost_priority,1
		dc.b ost_col_type,id_col_64x32+id_col_hurt
		dc.b so_set_parent,ost_lwall_parent
		dc.b so_end
		even
; ===========================================================================

LWall_Main:	; Routine 0
		addq.b	#id_LWall_Action,ost_routine(a0)	; goto LWall_Action next
		movea.l	a0,a1
		moveq	#1,d2
		bra.s	@make
; ===========================================================================

	@loop:
		bsr.w	FindNextFreeObj				; find free OST slot
		bne.s	@fail					; branch if not found

@make:
		lea	LWall_Settings(pc),a2
		bsr.w	SetupChild

	@fail:
		dbf	d2,@loop				; repeat sequence once

		addq.b	#id_LWall_BackHalf,ost_routine(a1)	; goto LWall_BackHalf next (2nd object only)
		move.b	#id_frame_lavawall_back,ost_frame(a1)	; use back of lava wall frame

LWall_Action:	; Routine 4
		move.w	(v_ost_player+ost_x_pos).w,d0
		sub.w	ost_x_pos(a0),d0
		bcc.s	@rangechk
		neg.w	d0

	@rangechk:
		cmpi.w	#$C0,d0					; is Sonic within 192px on x axis?
		bcc.s	@movewall				; if not, branch
		move.w	(v_ost_player+ost_y_pos).w,d0
		sub.w	ost_y_pos(a0),d0
		bcc.s	@rangechk2
		neg.w	d0

	@rangechk2:
		cmpi.w	#$60,d0					; is Sonic within 96px on y axis?
		bcc.s	@movewall				; if not, branch
		move.b	#1,ost_lwall_flag(a0)			; set object to move
		bra.s	LWall_Solid
; ===========================================================================

@movewall:
		tst.b	ost_lwall_flag(a0)			; is object set to move?
		beq.s	LWall_Solid				; if not, branch
		move.w	#$180,ost_x_vel(a0)			; set object speed
		subq.b	#2,ost_routine(a0)			; goto LWall_Solid next

LWall_Solid:	; Routine 2
		move.w	#$2B,d1
		move.w	#$18,d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	ost_x_pos(a0),d4
		move.b	ost_routine(a0),d0
		move.w	d0,-(sp)				; save routine counter to stack
		bsr.w	SolidObject
		move.w	(sp)+,d0
		move.b	d0,ost_routine(a0)			; restore routine counter from stack (unnecessary?)
		cmpi.w	#$6A0,ost_x_pos(a0)			; has object reached $6A0 on the x-axis?
		bne.s	@animate				; if not, branch
		clr.w	ost_x_vel(a0)				; stop object moving
		clr.b	ost_lwall_flag(a0)

	@animate:
		lea	(Ani_LWall).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#id_Sonic_Hurt,(v_ost_player+ost_routine).w ; is Sonic hurt or dead?
		bcc.s	@rangechk				; if yes, branch
		bsr.w	SpeedToPos				; update position

	@rangechk:
		bsr.w	DisplaySprite
		tst.b	ost_lwall_flag(a0)			; is wall already moving?
		bne.s	@moving					; if yes, branch
		out_of_range.s	@chkgone

	@moving:
		rts	
; ===========================================================================

@chkgone:
		lea	(v_respawn_list).w,a2
		moveq	#0,d0
		move.b	ost_respawn(a0),d0
		bclr	#7,2(a2,d0.w)
		move.b	#id_LWall_Delete,ost_routine(a0)
		rts	
; ===========================================================================

LWall_BackHalf:	; Routine 6
		movea.l	ost_lwall_parent(a0),a1			; get OST address of parent (front half)
		cmpi.b	#id_LWall_Delete,ost_routine(a1)	; is parent set to delete?
		beq.s	LWall_Delete				; if yes, branch
		move.w	ost_x_pos(a1),ost_x_pos(a0)		; match x position
		subi.w	#$80,ost_x_pos(a0)			; move 128px to the left
		bra.w	DisplaySprite
; ===========================================================================

LWall_Delete:	; Routine 8
		bra.w	DeleteObject

; ---------------------------------------------------------------------------
; Animation script
; ---------------------------------------------------------------------------

include_LavaWall_animation:	macro

Ani_LWall:	index *
		ptr ani_lavawall_0
		
ani_lavawall_0:	dc.b 9
		dc.b id_frame_lavawall_0
		dc.b id_frame_lavawall_1
		dc.b id_frame_lavawall_2
		dc.b id_frame_lavawall_3
		dc.b afEnd
		even

		endm
