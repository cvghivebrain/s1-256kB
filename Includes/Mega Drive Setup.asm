; ---------------------------------------------------------------------------
; Mega Drive setup/initialisation
; ---------------------------------------------------------------------------

EntryPoint:
		lea	(console_version).l,a0
		move.b	(a0),d0					; get hardware version (from $A10001)
		andi.b	#$F,d0
		beq.s	@no_tmss				; if the console has no TMSS, skip the security stuff
		move.l	#'SEGA',tmss_sega-console_version(a0)	; move "SEGA" to TMSS register ($A14000)
	@no_tmss: