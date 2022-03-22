; ---------------------------------------------------------------------------
; Animation script - Sonic
; ---------------------------------------------------------------------------

Ani_Sonic:	index *
		ptr Walk
		ptr Run
		ptr Roll
		ptr Roll2
		ptr Pushing
		ptr Wait
		ptr Balance
		ptr LookUp
		ptr Duck
		ptr Stop
		ptr Float2
		ptr Spring
		ptr Hang
		ptr GetAir
		ptr Drown
		ptr Death
		ptr Hurt
		ptr WaterSlide
		ptr Blank
		ptr Float3
		ptr Float4

Walk:		dc.b $FF
		dc.b id_frame_walk13
		dc.b id_frame_walk14
		dc.b id_frame_walk15
		dc.b id_frame_walk16
		dc.b id_frame_walk11
		dc.b id_frame_walk12
		dc.b afEnd
		even

Run:		dc.b $FF
		dc.b id_frame_run11
		dc.b id_frame_run12
		dc.b id_frame_run13
		dc.b id_frame_run14
		dc.b afEnd
		dc.b afEnd
		dc.b afEnd
		even

Roll:		dc.b $FE
		dc.b id_frame_Roll1
		dc.b id_frame_Roll2
		dc.b id_frame_Roll3
		dc.b id_frame_Roll4
		dc.b id_frame_Roll5
		dc.b afEnd
		dc.b afEnd
		even

Roll2:		dc.b $FE
		dc.b id_frame_Roll1
		dc.b id_frame_Roll2
		dc.b id_frame_Roll5
		dc.b id_frame_Roll3
		dc.b id_frame_Roll4
		dc.b id_frame_Roll5
		dc.b afEnd
		even

Pushing:	dc.b $FD
		dc.b id_frame_push1
		dc.b id_frame_push2
		dc.b id_frame_push3
		dc.b id_frame_push4
		dc.b afEnd
		dc.b afEnd
		dc.b afEnd
		even

Wait:		dc.b $17
		dc.b id_frame_stand
		dc.b id_frame_stand
		dc.b id_frame_stand
		dc.b id_frame_stand
		dc.b id_frame_stand
		dc.b id_frame_stand
		dc.b id_frame_stand
		dc.b id_frame_stand
		dc.b id_frame_stand
		dc.b id_frame_stand
		dc.b id_frame_stand
		dc.b id_frame_stand
		dc.b id_frame_wait2
		dc.b id_frame_wait1
		dc.b id_frame_wait1
		dc.b id_frame_wait1
		dc.b id_frame_wait2
		dc.b id_frame_wait3
		dc.b afBack, 2
		even

Balance:	dc.b $1F
		dc.b id_frame_balance1
		dc.b id_frame_balance2
		dc.b afEnd
		even

LookUp:		dc.b $3F
		dc.b id_frame_lookup
		dc.b afEnd
		even

Duck:		dc.b $3F
		dc.b id_frame_duck
		dc.b afEnd
		even

Stop:		dc.b 7
		dc.b id_frame_stop1
		dc.b id_frame_stop2
		dc.b afEnd
		even

Float2:		dc.b 7
		dc.b id_frame_float1
		dc.b id_frame_float2
		dc.b id_frame_float5
		dc.b id_frame_float3
		dc.b id_frame_float6
		dc.b afEnd
		even

Spring:		dc.b $2F
		dc.b id_frame_spring
		dc.b afChange, id_Walk
		even

Hang:		dc.b 4
		dc.b id_frame_hang1
		dc.b id_frame_hang2
		dc.b afEnd
		even

GetAir:		dc.b $B
		dc.b id_frame_getair
		dc.b id_frame_getair
		dc.b id_frame_walk15
		dc.b id_frame_walk16
		dc.b afChange, id_Walk
		even

Drown:		dc.b $2F
		dc.b id_frame_drown
		dc.b afEnd
		even

Death:		dc.b 3
		dc.b id_frame_death
		dc.b afEnd
		even

Hurt:		dc.b 3
		dc.b id_frame_injury
		dc.b afEnd
		even

WaterSlide:	dc.b 7
		dc.b id_frame_injury
		dc.b id_frame_waterslide
		dc.b afEnd
		even

Blank:		dc.b $77
		dc.b id_frame_blank
		dc.b afChange, id_Walk
		even

Float3:		dc.b 3
		dc.b id_frame_float1
		dc.b id_frame_float2
		dc.b id_frame_float5
		dc.b id_frame_float3
		dc.b id_frame_float6
		dc.b afEnd
		even

Float4:		dc.b 3
		dc.b id_frame_float1
		dc.b afChange, id_Walk
		even
