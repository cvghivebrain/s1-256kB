; ---------------------------------------------------------------------------
; Object 76 - blocks that Eggman picks up (SYZ)

; spawned by:
;	DynamicLevelEvents - routine 0
;	BossBlock - routine 2
; ---------------------------------------------------------------------------

BossBlock:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	BBlock_Index(pc,d0.w),d1
		jmp	BBlock_Index(pc,d1.w)
; ===========================================================================
BBlock_Index:	index *,,2
		ptr BBlock_Main
		ptr BBlock_Action
		ptr BBlock_Frag

ost_bblock_mode:	equ $29					; same as subtype = solid; $FF = lifted; $A = breaking
ost_bblock_boss:	equ $34					; address of OST of main boss object (4 bytes)

BBlock_Settings:
		dc.b ost_id,id_BossBlock
		dc.b so_write_long,ost_mappings
		dc.l Map_BossBlock
		dc.b so_write_word,ost_tile
		dc.w 0+tile_pal3
		dc.b ost_render,render_rel
		dc.b ost_actwidth,16
		dc.b ost_height,16
		dc.b ost_priority,3
		dc.b so_write_word,ost_y_pos
		dc.w $582
		dc.b ost_routine,2
		dc.b so_end
		even
; ===========================================================================

BBlock_Main:	; Routine 0
		moveq	#0,d4					; first subtype
		move.w	#$2C10,d5				; first x position
		moveq	#10-1,d6				; number of blocks
		lea	(a0),a1					; replace current object with first block
		bra.s	@load_block
; ===========================================================================

	@loop:
		jsr	(FindFreeObj).l				; find free OST slot
		bne.s	@fail					; branch if not found

@load_block:
		lea	BBlock_Settings(pc),a2
		jsr	SetupChild
		move.w	d5,ost_x_pos(a1)			; set x position
		move.w	d4,ost_subtype(a1)			; blocks have subtypes 0-9
		addi.w	#$101,d4				; increment subtype
		addi.w	#$20,d5					; +32px for next x position
		dbf	d6,@loop				; repeat sequence 9 more times

	@fail:
		rts	
; ===========================================================================

BBlock_Action:	; Routine 2
		move.b	ost_bblock_mode(a0),d0			; check mode (changed by SYZ boss when lifted)
		cmp.b	ost_subtype(a0),d0
		beq.s	@is_solid				; branch if same as subtype
		tst.b	d0
		bmi.s	@lifting				; branch if $FF

@break_block:
		bsr.w	BBlock_Break
		bra.s	@display
; ===========================================================================

@lifting:
		movea.l	ost_bblock_boss(a0),a1			; get address of OST of boss
		tst.b	ost_col_property(a1)			; has boss been hit 8 times?
		beq.s	@break_block				; if yes, branch

		move.w	ost_x_pos(a1),ost_x_pos(a0)		; move with boss
		move.w	ost_y_pos(a1),ost_y_pos(a0)
		addi.w	#$2C,ost_y_pos(a0)			; block is 44px below boss
		cmpa.w	a0,a1
		bcs.s	@display				; branch if boss OST is before block OST in RAM
		move.w	ost_y_vel(a1),d0
		ext.l	d0
		asr.l	#8,d0
		add.w	d0,ost_y_pos(a0)
		bra.s	@display
; ===========================================================================

@is_solid:
		move.w	#$1B,d1
		move.w	#$10,d2
		move.w	#$11,d3
		move.w	ost_x_pos(a0),d4
		jsr	(SolidObject).l

@display:
BBlock_display:
		jmp	(DisplaySprite).l
; ===========================================================================

BBlock_Frag:	; Routine 4
		tst.b	ost_render(a0)				; is object on-screen?
		bpl.w	BSYZ_delete					; if not, branch
		jsr	(ObjectFall).l				; apply gravity and update position
		bra.s	BBlock_display

; ---------------------------------------------------------------------------
; Subroutine to break block into fragments 
; ---------------------------------------------------------------------------

BBlock_Break:
		lea	BBlock_FragSpeed(pc),a4
		lea	BBlock_FragPos(pc),a5
		moveq	#id_frame_bblock_topleft,d4		; first fragment is top left
		moveq	#3,d1
		moveq	#$38,d2
		addq.b	#2,ost_routine(a0)			; goto BBlock_Frag next
		move.b	#8,ost_actwidth(a0)
		move.b	#8,ost_height(a0)
		lea	(a0),a1					; replace block with first fragment
		bra.s	@load_frag
; ===========================================================================

	@loop:
		jsr	(FindNextFreeObj).l			; find free OST slot
		bne.s	@fail					; branch if not found

@load_frag:
		lea	(a0),a2
		lea	(a1),a3
		moveq	#(sizeof_ost/4)-1,d3

	@loop_copy:
		move.l	(a2)+,(a3)+
		dbf	d3,@loop_copy				; copy contents of OST to other 3 fragments

		move.w	(a4)+,ost_x_vel(a1)
		move.w	(a4)+,ost_y_vel(a1)
		move.w	(a5)+,d3
		add.w	d3,ost_x_pos(a1)
		move.w	(a5)+,d3
		add.w	d3,ost_y_pos(a1)
		move.b	d4,ost_frame(a1)			; set frame (raw mappings are not used like in other broken blocks)
		addq.w	#1,d4					; use next frame
		dbf	d1,@loop				; repeat sequence 3 more times

	@fail:
		play.w	1, jmp, sfx_Smash			; play smashing sound
; End of function BBlock_Break

; ===========================================================================
BBlock_FragSpeed:
		dc.w -$180, -$200
		dc.w $180, -$200
		dc.w -$100, -$100
		dc.w $100, -$100

BBlock_FragPos:	dc.w -8, -8
		dc.w $10, 0
		dc.w 0,	$10
		dc.w $10, $10
