; ---------------------------------------------------------------------------
; Object 08 - water splash (LZ)

; spawned by:
;	SonicPlayer
; ---------------------------------------------------------------------------

Splash:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	Spla_Index(pc,d0.w),d1
		jmp	Spla_Index(pc,d1.w)
; ===========================================================================
Spla_Index:	index *,,2
		ptr Spla_Main
		ptr Spla_Display
		ptr Spla_Delete

Spla_Settings:	dc.b ost_routine,2
		dc.b so_write_long,ost_mappings
		dc.l Map_Splash
		dc.b ost_priority,1
		dc.b ost_actwidth,16
		dc.b so_write_word,ost_tile
		dc.w $23E+tile_pal3
		dc.b so_render_rel
		dc.b so_end
		even
; ===========================================================================

Spla_Main:	; Routine 0
		lea	Spla_Settings(pc),a2
		bsr.w	SetupObject
		move.w	(v_ost_player+ost_x_pos).w,ost_x_pos(a0) ; copy x position from Sonic

Spla_Display:	; Routine 2
		move.w	(v_water_height_actual).w,ost_y_pos(a0)	; copy y position from water height
		lea	(Ani_Splash).l,a1
		jsr	(AnimateSprite).l			; animate and goto Spla_Delete when finished
		jmp	(DisplaySprite).l
; ===========================================================================

Spla_Delete:	; Routine 4
		jmp	(DeleteObject).l			; delete when animation	is complete

; ---------------------------------------------------------------------------
; Animation script
; ---------------------------------------------------------------------------

include_Splash_animation:	macro

Ani_Splash:	index *
		ptr ani_splash_0
		
ani_splash_0:	dc.b 4
		dc.b id_frame_splash_0
		dc.b id_frame_splash_1
		dc.b id_frame_splash_2
		dc.b afRoutine
		even

		endm
