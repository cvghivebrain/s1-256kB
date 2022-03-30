; ---------------------------------------------------------------------------
; Subroutine to load basic level data
; ---------------------------------------------------------------------------

LevelDataLoad:
		moveq	#0,d0
		move.b	(v_zone).w,d0				; get zone number
		mulu.w	#10,d0					; multiply by 10
		lea	(LevelHeaders).l,a2			; address of level headers
		lea	(a2,d0.w),a2				; jump to relevant level header
		movea.l	(a2)+,a0				; load 16x16 pointer
		lea	(v_16x16_tiles).w,a1			; RAM address for 16x16 mappings
		move.w	#0,d0					; value to add to each tile = 0
		bsr.w	EniDec
		movea.l	(a2)+,a0				; load 256x256 mappings pointer
		lea	(v_256x256_tiles).l,a1			; RAM address for 256x256 mappings
		bsr.w	KosDec

		bsr.w	LevelLayoutLoad				; load level layout (doesn't involve level headers)
		move.w	(a2),d0					; load palette id
		cmpi.w	#(id_LZ<<8)+3,(v_zone).w		; is level SBZ3 (LZ4) ?
		bne.s	@notSBZ3				; if not, branch
		moveq	#id_Pal_SBZ3,d0				; use SB3 palette

	@notSBZ3:
		cmpi.w	#(id_SBZ<<8)+1,(v_zone).w		; is level SBZ2?
		beq.s	@isSBZorFZ				; if yes, branch
		cmpi.w	#(id_SBZ<<8)+2,(v_zone).w		; is level FZ?
		bne.s	@normalpal				; if not, branch

	@isSBZorFZ:
		moveq	#id_Pal_SBZ2,d0				; use SBZ2/FZ palette

	@normalpal:
		bsr.w	PalLoad_Next				; load palette (based on d0)
		move.b	(v_zone).w,d0				; get zone number
		lsl.w	#1,d0
		add.w	#1,d0
		cmp.b	#id_PLC_Boss,d0
		beq.s	@no_plc
		bsr.w	AddPLC					; load level graphics over next few frames
	@no_plc:
		rts

; ---------------------------------------------------------------------------
; Level	layout loading subroutine

; Levels are "cropped" in ROM. In RAM the level and background each comprise
; eight $40 byte rows, which are stored alternately.
; ---------------------------------------------------------------------------

LevelLayoutLoad:
		lea	(v_level_layout).w,a3
		move.w	#((v_sprite_queue-v_level_layout)/4)-1,d1
		moveq	#0,d0

	@clear_ram:
		move.l	d0,(a3)+
		dbf	d1,@clear_ram				; clear the RAM ($A400-ABFF)

		lea	(v_level_layout).w,a3			; RAM address for level layout
		moveq	#0,d1
		bsr.w	LevelLayoutLoad2			; load level layout into RAM
		lea	(v_level_layout+level_max_width).w,a3	; RAM address for background layout
		moveq	#2,d1

; "LevelLayoutLoad2" is	run twice - for	the level and the background

LevelLayoutLoad2:
		move.w	(v_zone).w,d0				; get zone & act numbers as word
		lsl.b	#6,d0					; move act number (bits 0/1) next to zone number
		lsr.w	#4,d0					; d0 = zone/act expressed as one byte
		add.w	d1,d0					; add d1: 0 for level; 2 for background
		lea	(Level_Index).l,a1
		move.w	(a1,d0.w),d0
		lea	(a1,d0.w),a1				; jump to actual level data
		moveq	#0,d1
		move.w	d1,d2
		move.b	(a1)+,d1				; load cropped level width (in tiles)
		move.b	(a1)+,d2				; load cropped level height (in tiles)

	@loop_row:
		move.w	d1,d0
		movea.l	a3,a0

	@loop_tile:
		move.b	(a1)+,(a0)+
		dbf	d0,@loop_tile				; load 1 row
		lea	sizeof_levelrow(a3),a3			; do next row
		dbf	d2,@loop_row				; repeat for number of rows
		rts

; ---------------------------------------------------------------------------
; Level Headers
; ---------------------------------------------------------------------------

lhead:		macro sixteen,twofivesix,pal
		dc.l sixteen
		dc.l twofivesix
		dc.w pal
		endm

include_levelheaders:	macro

LevelHeaders:
		lhead	Blk16_GHZ,	Blk256_GHZ,	id_Pal_GHZ ; Green Hill
		lhead	Blk16_LZ,	Blk256_LZ,	id_Pal_LZ ; Labyrinth
		lhead	Blk16_MZ,	Blk256_MZ,	id_Pal_MZ ; Marble
		lhead	Blk16_SLZ,	Blk256_SLZ,	id_Pal_SLZ ; Star Light
		lhead	Blk16_SYZ,	Blk256_SYZ,	id_Pal_SYZ ; Spring Yard
		lhead	Blk16_SBZ,	Blk256_SBZ,	id_Pal_SBZ1 ; Scrap Brain
		zonewarning LevelHeaders,10
		lhead	Blk16_GHZ,	Blk256_GHZ,	id_Pal_Ending ; Ending
		even

		endm
