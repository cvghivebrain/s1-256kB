; ---------------------------------------------------------------------------
; Subroutine to	pause the game
; ---------------------------------------------------------------------------

PauseGame:
		nop	
		tst.b	(v_lives).w				; do you have any lives	left?
		beq.s	Unpause					; if not, branch
		tst.w	(f_pause).w				; is game already paused?
		bne.s	@paused					; if yes, branch
		btst	#bitStart,(v_joypad_press_actual).w	; is Start button pressed?
		beq.s	Pause_DoNothing				; if not, branch

	@paused:
		move.w	#1,(f_pause).w				; set pause flag (also stops palette/gfx animations, time)
		move.b	#1,(v_snddriver_ram+f_pause_sound).w	; pause music

Pause_Loop:
		move.b	#id_VBlank_Pause,(v_vblank_routine).w
		bsr.w	WaitForVBlank				; wait for next frame
		btst	#bitStart,(v_joypad_press_actual).w	; is Start button pressed?
		beq.s	Pause_Loop				; if not, branch

Unpause_Music:
		move.b	#$80,(v_snddriver_ram+f_pause_sound).w	; unpause the music

Unpause:
		move.w	#0,(f_pause).w				; unpause the game

Pause_DoNothing:
		rts
