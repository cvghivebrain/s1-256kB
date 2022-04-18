; ---------------------------------------------------------------------------
; Pattern load cues
; ---------------------------------------------------------------------------
PatternLoadCues:
		index *
		ptr PLC_TitleCard
		ptr PLC_Boss
		ptr PLC_Signpost
		ptr PLC_Explode
		ptr PLC_GameOver
PLC_Animals:
		ptr PLC_GHZAnimals
		ptr PLC_LZAnimals
		ptr PLC_MZAnimals
		ptr PLC_SLZAnimals
		ptr PLC_SYZAnimals
		ptr PLC_SBZAnimals
		zonewarning PLC_Animals,2
		ptr PLC_SSResult
		ptr PLC_Ending
		ptr PLC_TryAgain
		ptr PLC_EggmanSBZ2
		ptr PLC_FZBoss

plcm:		macro gfx,vram,suffix
		dc.l gfx
		if strlen("\vram")>0
			plcm_vram: = \vram
		else
			plcm_vram: = last_vram
		endc
		last_vram: = plcm_vram+sizeof_\gfx
		dc.w plcm_vram
		if strlen("\suffix")>0
			tile_\gfx\_\suffix: equ plcm_vram/$20
			vram_\gfx\_\suffix: equ plcm_vram
		else
			if ~def(tile_\gfx)
			tile_\gfx: equ plcm_vram/$20
			vram_\gfx: equ plcm_vram
			endc
		endc
		endm

plcheader:	macro *
		\*: equ *
		plc_count\@: equ (\*_end-*-2)/sizeof_plc
		dc.w plc_count\@-1
		endm

; ---------------------------------------------------------------------------
; Pattern load cues - explosion
; ---------------------------------------------------------------------------
PLC_Explode:	plcheader
		plcm	Nem_Explode, $B400			; explosion
	PLC_Explode_end:
; ---------------------------------------------------------------------------
; Pattern load cues - game/time	over
; ---------------------------------------------------------------------------
PLC_GameOver:	plcheader
		plcm	Nem_GameOver, $ABC0			; game/time over
	PLC_GameOver_end:
; ---------------------------------------------------------------------------
; Pattern load cues - title card
; ---------------------------------------------------------------------------
PLC_TitleCard:	plcheader
		plcm	Nem_TitleCard, $B000
	PLC_TitleCard_end:
; ---------------------------------------------------------------------------
; Pattern load cues - act 3 boss
; ---------------------------------------------------------------------------
PLC_Boss:	plcheader
		plcm	Nem_Eggman, $8000			; Eggman main patterns
		plcm	Nem_Weapons				; Eggman's weapons ($8D80)
		plcm	Nem_Prison, $93A0			; prison capsule
		plcm	Nem_Exhaust, $A540			; exhaust flame
	PLC_Boss_end:
; ---------------------------------------------------------------------------
; Pattern load cues - act 1/2 signpost
; ---------------------------------------------------------------------------
PLC_Signpost:	plcheader
		plcm	Nem_SignPost, $D000			; signpost
		plcm	Nem_BigRing, vram_giantring
		plcm	Nem_Bonus, $96C0			; hidden bonus points
		plcm	Nem_BigFlash, $8C40			; giant	ring flash effect
	PLC_Signpost_end:
; ---------------------------------------------------------------------------
; Pattern load cues - GHZ animals
; ---------------------------------------------------------------------------
PLC_GHZAnimals:	plcheader
		plcm	Nem_Rabbit, vram_animal1		; rabbit ($B000)
		plcm	Nem_Flicky, vram_animal2		; flicky ($B240)
	PLC_GHZAnimals_end:
; ---------------------------------------------------------------------------
; Pattern load cues - LZ animals
; ---------------------------------------------------------------------------
PLC_LZAnimals:	plcheader
		plcm	Nem_BlackBird, vram_animal1		; blackbird ($B000)
		plcm	Nem_Seal, vram_animal2			; seal ($B240)
	PLC_LZAnimals_end:
; ---------------------------------------------------------------------------
; Pattern load cues - MZ animals
; ---------------------------------------------------------------------------
PLC_MZAnimals:	plcheader
		plcm	Nem_Squirrel, vram_animal1		; squirrel ($B000)
		plcm	Nem_Seal, vram_animal2			; seal ($B240)
	PLC_MZAnimals_end:
; ---------------------------------------------------------------------------
; Pattern load cues - SLZ animals
; ---------------------------------------------------------------------------
PLC_SLZAnimals:	plcheader
		plcm	Nem_Pig, vram_animal1			; pig ($B000)
		plcm	Nem_Flicky, vram_animal2		; flicky ($B240)
	PLC_SLZAnimals_end:
; ---------------------------------------------------------------------------
; Pattern load cues - SYZ animals
; ---------------------------------------------------------------------------
PLC_SYZAnimals:	plcheader
		plcm	Nem_Pig, vram_animal1			; pig ($B000)
		plcm	Nem_Chicken, vram_animal2		; chicken ($B240)
	PLC_SYZAnimals_end:
; ---------------------------------------------------------------------------
; Pattern load cues - SBZ animals
; ---------------------------------------------------------------------------
PLC_SBZAnimals:	plcheader
		plcm	Nem_Rabbit, vram_animal1		; rabbit ($B000)
		plcm	Nem_Chicken, vram_animal2		; chicken ($B240)
	PLC_SBZAnimals_end:
; ---------------------------------------------------------------------------
; Pattern load cues - special stage results screen
; ---------------------------------------------------------------------------
PLC_SSResult:	plcheader
		plcm	Nem_ResultEm, $A820			; emeralds
		plcm	Nem_MiniSonic				; mini Sonic ($AA20)
	PLC_SSResult_end:
; ---------------------------------------------------------------------------
; Pattern load cues - ending sequence
; ---------------------------------------------------------------------------
PLC_Ending:	plcheader
		;plcm	Nem_GHZ_1st,0				; GHZ main patterns
		;plcm	Nem_GHZ_2nd, $39A0			; GHZ secondary	patterns
		plcm	Nem_EndFlower, $7400			; flowers
		plcm	Nem_EndEm				; emeralds ($78A0)
		plcm	Nem_EndSonic				; Sonic ($7C20)
		plcm	Nem_Rabbit, $AA60, End			; rabbit
		plcm	Nem_Chicken,, End			; chicken ($ACA0)
		plcm	Nem_BlackBird,, End			; blackbird ($AE60)
		plcm	Nem_Seal,, End				; seal ($B0A0)
		plcm	Nem_Pig,, End				; pig ($B260)
		plcm	Nem_Flicky,, End			; flicky ($B4A0)
		plcm	Nem_Squirrel,, End			; squirrel ($B660)
		plcm	Nem_EndStH				; "SONIC THE HEDGEHOG" ($B8A0)
	PLC_Ending_end:
; ---------------------------------------------------------------------------
; Pattern load cues - "TRY AGAIN" and "END" screens
; ---------------------------------------------------------------------------
PLC_TryAgain:	plcheader
		plcm	Nem_EndEm, $78A0, TryAgain		; emeralds
		plcm	Nem_TryAgain				; Eggman ($7C20)
		plcm	Nem_CreditText, vram_credits		; credits alphabet ($B400)
	PLC_TryAgain_end:
; ---------------------------------------------------------------------------
; Pattern load cues - Eggman on SBZ 2
; ---------------------------------------------------------------------------
PLC_EggmanSBZ2:	plcheader
		plcm	Nem_Sbz2Eggman, $8800			; Eggman
	PLC_EggmanSBZ2_end:
; ---------------------------------------------------------------------------
; Pattern load cues - final boss
; ---------------------------------------------------------------------------
PLC_FZBoss:	plcheader
		plcm	Nem_FzEggman, $7400			; Eggman after boss
		plcm	Nem_FzBoss, $6000			; FZ boss
		plcm	Nem_Eggman, $8000			; Eggman main patterns
		plcm	Nem_Sbz2Eggman, $8E00, FZ		; Eggman without ship
		plcm	Nem_Exhaust, $A540			; exhaust flame
	PLC_FZBoss_end:
		even
