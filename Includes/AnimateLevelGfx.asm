; ---------------------------------------------------------------------------
; Subroutine to	load uncompressed gfx for level animations & giant ring

; output:
;	a6 = vdp_data_port ($C00000)
;	uses d0, d1, d2, d3, a1, a2, a3, a4
; ---------------------------------------------------------------------------

AnimateLevelGfx:
		tst.w	(f_pause).w				; is the game paused?
		bne.s	@ispaused				; if yes, branch
		lea	(vdp_data_port).l,a6
		moveq	#0,d0
		move.b	(v_zone).w,d0
		add.w	d0,d0
		move.w	AniArt_Index(pc,d0.w),d0
		jmp	AniArt_Index(pc,d0.w)

	@ispaused:
		rts	

; ===========================================================================
AniArt_Index:	index *
		ptr AniArt_GHZ
		ptr AniArt_none
		ptr AniArt_MZ
		ptr AniArt_none
		ptr AniArt_none
		ptr AniArt_SBZ
		zonewarning AniArt_Index,2
		ptr AniArt_Ending

; ---------------------------------------------------------------------------
; Animated pattern routine - Green Hill
; ---------------------------------------------------------------------------

AniArt_GHZ:
		lea	(AniArt_GHZ_Script).l,a3

AniArt_Run:
		lea	(v_levelani_0_frame).w,a2
		move.w	(a3)+,d0				; get script count

	@loop:
		sub.w	#1,2(a2)				; decrement timer
		tst.w	2(a2)
		bpl.s	@next					; branch if time remains

		moveq	#0,d1
		movea.l	(a3),a1					; get gfx pointer
		move.w	4(a3),d1				; get frame size
		move.b	6(a3),d2				; get frame count
		move.w	6(a3),2(a2)				; reset frame time
		and.w	#$FF,2(a2)				; read only low byte
		movea.l	8(a3),a4				; get sequence pointer
		moveq	#0,d3
		move.b	(a2),d3					; get frame number
		add.b	#1,(a2)					; next frame
		cmp.b	(a2),d2
		bne.s	@frame_ok				; branch if valid
		move.b	#0,(a2)					; reset to 0
	@frame_ok:
		moveq	#0,d4
		move.b	(a4,d3.w),d4				; get byte from sequence
		tst.b	d4
		bpl.s	@not_long				; branch if long frame flag isn't set
		bclr	#7,d4					; clear flag
		move.w	-2(a4),2(a2)				; set time for long duration
	@not_long:
		move.w	d1,d3					; copy frame size
		lsr.w	#5,d1					; convert to tile count
		sub.w	#1,d1
		mulu.w	d4,d3					; jump to position within gfx
		adda.w	d3,a1					; jump to actual gfx address
		move.l	12(a3),4(a6)				; set target in VRAM
		bsr.w	LoadTiles				; copy tiles to VRAM
		
	@next:
		lea	16(a3),a3				; jump to next script
		lea	4(a2),a2				; next time/frame counter in RAM
		dbf	d0,@loop				; repeat for all scripts
		rts

AniArt_GHZ_Script:
		dc.w 3-1					; script count
		
		dc.l v_ghz_art					; gfx pointer
		dc.w 8*sizeof_cell				; cells per frame
		dc.b 2, 5					; frame count, time
		dc.l Art_GhzWater_Seq				; sequence pointer
		dc.l $40000000+(($6F00&$3FFF)<<16)+(($6F00&$C000)>>14) ; VRAM address
		
		dc.l v_ghz_art+$200				; gfx pointer
		dc.w 16*sizeof_cell				; cells per frame
		dc.b 2, 15					; frame count, time
		dc.l Art_GhzWater_Seq				; sequence pointer
		dc.l $40000000+(($6B80&$3FFF)<<16)+(($6B80&$C000)>>14) ; VRAM address
		
		dc.l v_ghz_art+$200+$400			; gfx pointer
		dc.w 12*sizeof_cell				; cells per frame
		dc.b 4, 7					; frame count, time
		dc.l Art_GhzFlower2_Seq				; sequence pointer
		dc.l $40000000+(($6D80&$3FFF)<<16)+(($6D80&$C000)>>14) ; VRAM address

Art_GhzWater_Seq:
		dc.b 0, 1, 2, 3
		
		dc.w $7F					; time to use for longer frames
Art_GhzFlower2_Seq:
		dc.b $80, 1, $82, 1				; +$80 for longer frame

; ---------------------------------------------------------------------------
; Animated pattern routine - Marble
; ---------------------------------------------------------------------------

AniArt_MZ_Script:
		dc.w 2-1					; script count
		
		dc.l v_mz_art					; gfx pointer
		dc.w 8*sizeof_cell				; cells per frame
		dc.b 3, 19					; frame count, time
		dc.l Art_GhzWater_Seq				; sequence pointer
		dc.l $40000000+(($5C40&$3FFF)<<16)+(($5C40&$C000)>>14) ; VRAM address
		
		dc.l v_mz_art+$300				; gfx pointer
		dc.w 6*sizeof_cell				; cells per frame
		dc.b 4, 7					; frame count, time
		dc.l Art_GhzWater_Seq				; sequence pointer
		dc.l $40000000+(($5E40&$3FFF)<<16)+(($5E40&$C000)>>14) ; VRAM address

AniArt_MZ:
		lea	(AniArt_MZ_Script).l,a3
		bsr.w	AniArt_Run

AniArt_MZ_Magma:

tilecount:	= 4						; 4 per column, 16 total

		subq.b	#1,(v_levelani_4_time).w		; decrement timer
		bpl.s	@end					; branch if not -1
		
		move.b	#1,(v_levelani_4_time).w		; time between each gfx change
		moveq	#0,d0
		move.b	(v_levelani_0_frame).w,d0		; get surface lava frame number
		lea	(v_mz_art+$300+$300).l,a4			; magma gfx
		ror.w	#7,d0					; multiply frame num by $200
		adda.w	d0,a4					; jump to appropriate tile
		locVRAM	$5A40
		moveq	#0,d3
		move.b	(v_levelani_4_frame).w,d3
		addq.b	#1,(v_levelani_4_frame).w		; increment frame counter (unused)
		move.b	(v_oscillating_table+8).w,d3		; get oscillating value
		move.w	#4-1,d2					; number of columns of tiles

	@loop:
		move.w	d3,d0
		add.w	d0,d0
		andi.w	#$1E,d0					; d0 = low nybble of oscillating value * 2
		lea	(AniArt_MZ_Magma_Index).l,a3
		move.w	(a3,d0.w),d0
		lea	(a3,d0.w),a3
		movea.l	a4,a1					; a1 = magma gfx
		move.w	#((tilecount*sizeof_cell)/4)-1,d1	; $1F
		jsr	(a3)					; copy gfx to VRAM
		addq.w	#4,d3					; increment initial oscillating value
		dbf	d2,@loop				; repeat 3 times
	@end:
AniArt_SBZ_none:
		rts

; ---------------------------------------------------------------------------
; Animated pattern routine - Scrap Brain
; ---------------------------------------------------------------------------

AniArt_SBZ_Script:
		dc.w 2-1					; script count
		
		dc.l v_sbz_art					; gfx pointer
		dc.w 12*sizeof_cell				; cells per frame
		dc.b 8, 7					; frame count, time
		dc.l Art_SBZ_Seq				; sequence pointer
		dc.l $40000000+(($9E00&$3FFF)<<16)+(($9E00&$C000)>>14) ; VRAM address
		
		dc.l v_sbz_art					; gfx pointer
		dc.w 12*sizeof_cell				; cells per frame
		dc.b 8, 7					; frame count, time
		dc.l Art_SBZ_Seq2				; sequence pointer
		dc.l $40000000+(($9F80&$3FFF)<<16)+(($9F80&$C000)>>14) ; VRAM address

		dc.w 180
Art_SBZ_Seq:	dc.b $80, 1, 2, 3, 4, 5, 6, 7
		dc.w 120
Art_SBZ_Seq2:	dc.b $80, 1, 2, 3, 4, 5, 6, 7

AniArt_SBZ:
		cmpi.b	#1,(v_act).w
		beq.s	AniArt_SBZ_none
		lea	(AniArt_SBZ_Script).l,a3
		bra.w	AniArt_Run

; ---------------------------------------------------------------------------
; Animated pattern routine - ending sequence
; ---------------------------------------------------------------------------

AniArt_End_Script:
		dc.w 5-1					; script count
		
		dc.l v_ghz_art+$200				; gfx pointer
		dc.w 16*sizeof_cell				; cells per frame
		dc.b 2, 7					; frame count, time
		dc.l Art_GhzWater_Seq				; sequence pointer
		dc.l $40000000+(($6B80&$3FFF)<<16)+(($6B80&$C000)>>14) ; VRAM address
		
		dc.l v_ghz_flower_buffer			; gfx pointer
		dc.w 16*sizeof_cell				; cells per frame
		dc.b 2, 7					; frame count, time
		dc.l Art_GhzWater_Seq				; sequence pointer
		dc.l $40000000+(($7200&$3FFF)<<16)+(($7200&$C000)>>14) ; VRAM address
		
		dc.l v_ghz_art+$200+$400			; gfx pointer
		dc.w 12*sizeof_cell				; cells per frame
		dc.b 8, 7					; frame count, time
		dc.l Art_EndFlower_Seq				; sequence pointer
		dc.l $40000000+(($6D80&$3FFF)<<16)+(($6D80&$C000)>>14) ; VRAM address

		dc.l v_ghz_flower_buffer+$400			; gfx pointer
		dc.w 16*sizeof_cell				; cells per frame
		dc.b 4, 14					; frame count, time
		dc.l Art_EndFlower_Seq2				; sequence pointer
		dc.l $40000000+(($7000&$3FFF)<<16)+(($7000&$C000)>>14) ; VRAM address

		dc.l v_ghz_flower_buffer+$A00			; gfx pointer
		dc.w 16*sizeof_cell				; cells per frame
		dc.b 4, 11					; frame count, time
		dc.l Art_EndFlower_Seq2				; sequence pointer
		dc.l $40000000+(($6800&$3FFF)<<16)+(($6800&$C000)>>14) ; VRAM address

Art_EndFlower_Seq:
		dc.b 0,	0, 0, 1, 2, 2, 2, 1
Art_EndFlower_Seq2:
		dc.b 0,	1, 2, 1
		
AniArt_Ending:
		lea	(AniArt_End_Script).l,a3
		bra.w	AniArt_Run

; ---------------------------------------------------------------------------
; Subroutine to	transfer graphics to VRAM

; input:
;	a1 = source address
;	a6 = vdp_data_port ($C00000)
;	d1 = number of tiles to load (minus one)
; ---------------------------------------------------------------------------

LoadTiles:
		rept sizeof_cell/4
		move.l	(a1)+,(a6)				; copy 1 tile to VRAM
		endr
		dbf	d1,LoadTiles
AniArt_none:
		rts

; ---------------------------------------------------------------------------
; Subroutines to animate MZ magma

; input:
;	d1 = number of longwords to write to VRAM
;	a1 = address of magma gfx (stored as 32x32 image)
;	a6 = vdp_data_port ($C00000)

;	uses d0
; ---------------------------------------------------------------------------

AniArt_MZ_Magma_Index:
		index *
		ptr AniArt_MZ_Magma_Shift0_Col0
		ptr AniArt_MZ_Magma_Shift1_Col0
		ptr AniArt_MZ_Magma_Shift2_Col0
		ptr AniArt_MZ_Magma_Shift3_Col0
		ptr AniArt_MZ_Magma_Shift0_Col1
		ptr AniArt_MZ_Magma_Shift1_Col1
		ptr AniArt_MZ_Magma_Shift2_Col1
		ptr AniArt_MZ_Magma_Shift3_Col1
		ptr AniArt_MZ_Magma_Shift0_Col2
		ptr AniArt_MZ_Magma_Shift1_Col2
		ptr AniArt_MZ_Magma_Shift2_Col2
		ptr AniArt_MZ_Magma_Shift3_Col2
		ptr AniArt_MZ_Magma_Shift0_Col3
		ptr AniArt_MZ_Magma_Shift1_Col3
		ptr AniArt_MZ_Magma_Shift2_Col3
		ptr AniArt_MZ_Magma_Shift3_Col3
; ===========================================================================

AniArt_MZ_Magma_Shift0_Col0:
		move.l	(a1),(a6)				; write 8px row to VRAM
		lea	$10(a1),a1				; read next 32px row from source
		dbf	d1,AniArt_MZ_Magma_Shift0_Col0		; repeat for column of 4 tiles
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift1_Col0:
		move.l	2(a1),d0
		move.b	1(a1),d0
		ror.l	#8,d0
		move.l	d0,(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift1_Col0
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift2_Col0:
		move.l	2(a1),(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift2_Col0
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift3_Col0:
		move.l	4(a1),d0
		move.b	3(a1),d0
		ror.l	#8,d0
		move.l	d0,(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift3_Col0
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift0_Col1:
		move.l	4(a1),(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift0_Col1
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift1_Col1:
		move.l	6(a1),d0
		move.b	5(a1),d0
		ror.l	#8,d0
		move.l	d0,(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift1_Col1
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift2_Col1:
		move.l	6(a1),(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift2_Col1
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift3_Col1:
		move.l	8(a1),d0
		move.b	7(a1),d0
		ror.l	#8,d0
		move.l	d0,(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift3_Col1
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift0_Col2:
		move.l	8(a1),(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift0_Col2
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift1_Col2:
		move.l	$A(a1),d0
		move.b	9(a1),d0
		ror.l	#8,d0
		move.l	d0,(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift1_Col2
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift2_Col2:
		move.l	$A(a1),(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift2_Col2
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift3_Col2:
		move.l	$C(a1),d0
		move.b	$B(a1),d0
		ror.l	#8,d0
		move.l	d0,(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift3_Col2
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift0_Col3:
		move.l	$C(a1),(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift0_Col3
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift1_Col3:
		move.l	$C(a1),d0
		rol.l	#8,d0
		move.b	0(a1),d0
		move.l	d0,(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift1_Col3
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift2_Col3:
		move.w	$E(a1),(a6)
		move.w	0(a1),(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift2_Col3
		rts	
; ===========================================================================

AniArt_MZ_Magma_Shift3_Col3:
		move.l	0(a1),d0
		move.b	$F(a1),d0
		ror.l	#8,d0
		move.l	d0,(a6)
		lea	$10(a1),a1
		dbf	d1,AniArt_MZ_Magma_Shift3_Col3
		rts	
