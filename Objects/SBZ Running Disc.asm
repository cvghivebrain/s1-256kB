; ---------------------------------------------------------------------------
; Object 67 - disc that	you run	around (SBZ)

; spawned by:
;	ObjPos_SBZ2 - subtype $40
; ---------------------------------------------------------------------------

RunningDisc:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	Disc_Index(pc,d0.w),d1
		jmp	Disc_Index(pc,d1.w)
; ===========================================================================
Disc_Index:	index *,,2
		ptr Disc_Main
		ptr Disc_Action

ost_disc_y_start:	equ $30					; original y-axis position (2 bytes)
ost_disc_x_start:	equ $32					; original x-axis position (2 bytes)
ost_disc_inner_radius:	equ $34					; distance of small circle from centre
ost_disc_rotation:	equ $36					; rate/direction of small circle rotation (2 bytes)
ost_disc_outer_radius:	equ $38					; distance of Sonic from centre
ost_disc_init_flag:	equ $3A					; set when Sonic lands on the disc

Disc_Settings:	dc.b ost_routine,2
		dc.b so_write_long,ost_mappings
		dc.l Map_Disc
		dc.b so_write_word,ost_tile
		dc.w $31A+tile_pal3+tile_hi
		dc.b ost_render,render_rel
		dc.b ost_priority,4
		dc.b ost_actwidth,8
		dc.b so_end
		even
; ===========================================================================

Disc_Main:	; Routine 0
		lea	Disc_Settings(pc),a2
		bsr.w	SetupObject
		move.w	ost_x_pos(a0),ost_disc_x_start(a0)
		move.w	ost_y_pos(a0),ost_disc_y_start(a0)
		move.b	ost_status(a0),d0			; get object status
		ror.b	#2,d0					; move x/yflip bits to top
		andi.b	#(status_xflip+status_yflip)<<6,d0	; read only those
		move.b	d0,ost_angle(a0)			; use as starting angle

Disc_Action:	; Routine 2
		bsr.s	Disc_Detect
		bsr.w	Disc_MoveSpot
		bra.w	Disc_ChkDel

; ---------------------------------------------------------------------------
; Subroutine to detect collision with disc and set Sonic's inertia
; ---------------------------------------------------------------------------

Disc_Detect:
		lea	(v_ost_player).w,a1
		move.w	ost_x_pos(a1),d0
		sub.w	ost_disc_x_start(a0),d0
		add.w	#$48,d0
		cmp.w	#$90,d0
		bcc.s	@not_on_disc
		move.w	ost_y_pos(a1),d1
		sub.w	ost_disc_y_start(a0),d1
		add.w	#$48,d1
		cmp.w	#$90,d1
		bcc.s	@not_on_disc				; branch if Sonic is outside the range of the disc
		btst	#status_air_bit,ost_status(a1)		; is Sonic in the air?
		beq.s	Disc_Inertia				; if not, branch
		clr.b	ost_disc_init_flag(a0)
		rts	
; ===========================================================================

@not_on_disc:
		tst.b	ost_disc_init_flag(a0)			; was Sonic on the disc last frame?
		beq.s	@skip_clear				; if not, branch
		clr.b	ost_sonic_sbz_disc(a1)
		clr.b	ost_disc_init_flag(a0)

	@skip_clear:
		rts	
; ===========================================================================

Disc_Inertia:
		tst.b	ost_disc_init_flag(a0)			; was Sonic on the disc last frame?
		bne.s	@skip_init				; if yes, branch
		move.b	#1,ost_disc_init_flag(a0)		; set flag for Sonic being on the disc
		btst	#status_jump_bit,ost_status(a1)		; is Sonic jumping?
		bne.s	@jumping				; if yes, branch
		clr.b	ost_anim(a1)				; use walking animation

	@jumping:
		bclr	#status_pushing_bit,ost_status(a1)
		move.b	#id_Run,ost_anim_restart(a1)		; use running animation
		move.b	#1,ost_sonic_sbz_disc(a1)		; keep Sonic stuck to disc until he jumps

	@skip_init:
		move.w	ost_inertia(a1),d0
		cmpi.w	#$400,d0
		bge.s	@chk_max
		move.w	#$400,ost_inertia(a1)			; set minimum inertia on disc
		rts	
; ===========================================================================

@chk_max:
		cmpi.w	#$F00,d0
		ble.s	@exit
		move.w	#$F00,ost_inertia(a1)			; set maximum inertia on disc

	@exit:
		rts	
; ===========================================================================

Disc_MoveSpot:
		add.w	#$200,ost_angle(a0)			; update angle
		move.b	ost_angle(a0),d0
		jsr	(CalcSine).l				; convert to sine/cosine
		move.w	ost_disc_y_start(a0),d2
		move.w	ost_disc_x_start(a0),d3
		muls.w	#$1800,d0
		swap	d0
		muls.w	#$1800,d1
		swap	d1
		add.w	d2,d0
		add.w	d3,d1
		move.w	d0,ost_y_pos(a0)			; update position
		move.w	d1,ost_x_pos(a0)
		rts	
; ===========================================================================

Disc_ChkDel:
		out_of_range.s	@delete,ost_disc_x_start(a0)
		jmp	(DisplaySprite).l

	@delete:
		jmp	(DeleteObject).l
