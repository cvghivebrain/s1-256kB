; ---------------------------------------------------------------------------
; Object 1F - Crabmeat enemy (GHZ, SYZ)

; spawned by:
;	ObjPos_GHZ1, ObjPos_GHZ2, ObjPos_GHZ3 - routine 0
;	ObjPos_SYZ1, ObjPos_SYZ2, ObjPos_SYZ3 - routine 0
;	Crabmeat - routine 6
; ---------------------------------------------------------------------------

Crabmeat:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	Crab_Index(pc,d0.w),d1
		jmp	Crab_Index(pc,d1.w)
; ===========================================================================
Crab_Index:	index *,,2
		ptr Crab_Main
		ptr Crab_Action
		ptr Crab_Delete
		ptr Crab_BallMain
		ptr Crab_BallMove

ost_crab_wait_time:	equ $30					; time until crabmeat fires (2 bytes)
ost_crab_mode:		equ $32					; current action - 0/1 = not firing; 2/3 = firing

Crab_Settings:	dc.b ost_height,16
		dc.b ost_width,8
		dc.b -2,ost_tile
		dc.w $45E
		dc.b -3,ost_mappings
		dc.l Map_Crab
		dc.b ost_render,render_rel
		dc.b ost_priority,3
		dc.b ost_col_type,id_col_16x16
		dc.b ost_actwidth,$15
		dc.b -1
		even
; ===========================================================================

Crab_Main:	; Routine 0
		lea	Crab_Settings(pc),a2
		bsr.w	SetupObject
		cmpi.b	#id_GHZ,(v_zone).w
		beq.s	@is_ghz
		move.w	#$411,ost_tile(a0)			; SYZ
		
	@is_ghz:
		bsr.w	ObjectFall				; make crabmeat fall
		jsr	(FindFloorObj).l			; find floor
		tst.w	d1					; has crabmeat hit floor?
		bpl.s	@floornotfound				; if not, branch
		add.w	d1,ost_y_pos(a0)			; align to floor
		move.b	d3,ost_angle(a0)			; copy floor angle
		move.w	#0,ost_y_vel(a0)			; stop falling
		addq.b	#2,ost_routine(a0)			; goto Crab_Action next

	@floornotfound:
		rts	
; ===========================================================================

Crab_Action:	; Routine 2
		moveq	#0,d0
		move.b	ost_routine2(a0),d0
		move.w	Crab_Action_Index(pc,d0.w),d1
		jsr	Crab_Action_Index(pc,d1.w)
		lea	(Ani_Crab).l,a1
		bsr.w	AnimateSprite
		bra.w	DespawnObject
; ===========================================================================
Crab_Action_Index:
		index *
		ptr Crab_WaitFire
		ptr Crab_Walk
; ===========================================================================

Crab_WaitFire:
		subq.w	#1,ost_crab_wait_time(a0)		; decrement timer
		bpl.s	@dontmove				; branch if time remains
		tst.b	ost_render(a0)				; is crabmeat on-screen?
		bpl.s	@movecrab				; if not, branch
		bchg	#1,ost_crab_mode(a0)			; change flag for firing
		bne.s	@fire					; branch if previously set

	@movecrab:
		addq.b	#2,ost_routine2(a0)			; goto Crab_Walk next
		move.w	#127,ost_crab_wait_time(a0)		; set time delay to approx 2 seconds
		move.w	#$80,ost_x_vel(a0)			; move Crabmeat to the right
		move.b	#id_ani_crab_walk,ost_anim(a0)
		bchg	#status_xflip_bit,ost_status(a0)
		bne.s	@noflip
		neg.w	ost_x_vel(a0)				; change direction

	@dontmove:
	@noflip:
		rts	
; ===========================================================================

@fire:
		move.w	#59,ost_crab_wait_time(a0)
		move.b	#id_ani_crab_firing,ost_anim(a0)	; use firing animation
		bsr.s	@failleft
		subi.w	#$20,ost_x_pos(a1)
		move.w	#-$100,ost_x_vel(a1)

	@failleft:
		bsr.w	FindFreeObj
		bne.s	@failright
		move.b	#id_Crabmeat,ost_id(a1)			; load right fireball
		move.b	#id_Crab_BallMain,ost_routine(a1)
		move.w	ost_x_pos(a0),ost_x_pos(a1)
		addi.w	#$10,ost_x_pos(a1)
		move.w	ost_y_pos(a0),ost_y_pos(a1)
		move.w	#$100,ost_x_vel(a1)
		move.w	ost_tile(a0),ost_tile(a1)

	@failright:
		rts	
; ===========================================================================

Crab_Walk:
		subq.w	#1,ost_crab_wait_time(a0)		; decrement timer
		bmi.s	@stop					; branch if -1
		bsr.w	SpeedToPos				; update position
		bchg	#0,ost_crab_mode(a0)			; change flag for floor check
		bne.s	@findfloor_here				; branch if previously set
		move.w	ost_x_pos(a0),d3
		addi.w	#$10,d3					; find floor 16px to the right
		btst	#status_xflip_bit,ost_status(a0)
		beq.s	@noflip
		subi.w	#$20,d3					; find floor 16px to the left

	@noflip:
		jsr	(FindFloorObj2).l
		cmpi.w	#-8,d1					; is there a wall ahead?
		blt.s	@stop					; if yes, branch
		cmpi.w	#$C,d1					; is there a drop ahead?
		bge.s	@stop					; if yes, branch
		rts	
; ===========================================================================

@findfloor_here:
		jsr	(FindFloorObj).l			; find floor at current position
		add.w	d1,ost_y_pos(a0)			; align to floor
		move.b	#id_ani_crab_walk,ost_anim(a0)
		rts	
; ===========================================================================

@stop:
		subq.b	#2,ost_routine2(a0)			; goto Crab_WaitFire next
		move.w	#59,ost_crab_wait_time(a0)
		move.w	#0,ost_x_vel(a0)
		move.b	#id_ani_crab_stand,ost_anim(a0)	; use standing animation
		rts

; ===========================================================================

Crab_Delete:	; Routine 4
		bra.w	DeleteObject

; ---------------------------------------------------------------------------
; Sub-object - missile that the	Crabmeat throws
; ---------------------------------------------------------------------------

Crab_BallMain:	; Routine 6
		addq.b	#2,ost_routine(a0)			; goto Crab_BallMove next
		move.l	#Map_Crab,ost_mappings(a0)
		move.b	#render_rel,ost_render(a0)
		move.b	#3,ost_priority(a0)
		move.b	#id_col_6x6+id_col_hurt,ost_col_type(a0)
		move.b	#8,ost_actwidth(a0)
		move.w	#-$400,ost_y_vel(a0)
		move.b	#id_ani_crab_ball,ost_anim(a0)

Crab_BallMove:	; Routine 8
		lea	(Ani_Crab).l,a1
		bsr.w	AnimateSprite
		bsr.w	ObjectFall
		bsr.w	DisplaySprite
		move.w	(v_boundary_bottom).w,d0
		addi.w	#224,d0
		cmp.w	ost_y_pos(a0),d0			; has object moved below the level boundary?
		bcs.s	Crab_Delete					; if yes, branch
		rts	

; ---------------------------------------------------------------------------
; Animation script
; ---------------------------------------------------------------------------

Ani_Crab:	index *
		ptr ani_crab_stand
		ptr ani_crab_walk
		ptr ani_crab_firing
		ptr ani_crab_ball
		
ani_crab_stand:
		dc.b $F
		dc.b id_frame_crab_stand
		dc.b afEnd

ani_crab_walk:
		dc.b $F
		dc.b id_frame_crab_walk
		dc.b id_frame_crab_walk+afxflip
		dc.b id_frame_crab_stand
		dc.b afEnd

ani_crab_firing:
		dc.b $F
		dc.b id_frame_crab_firing
		dc.b afEnd

ani_crab_ball:
		dc.b 1
		dc.b id_frame_crab_ball1
		dc.b id_frame_crab_ball2
		dc.b afEnd
		even
