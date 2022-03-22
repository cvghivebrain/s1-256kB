; ---------------------------------------------------------------------------
; Sprite mappings - Sonic
; ---------------------------------------------------------------------------
frame_Blank:
Map_Sonic:	index *,,
		ptr frame_Blank
		ptr frame_Stand
		ptr frame_Wait1
		ptr frame_Wait2
		ptr frame_Wait3
		ptr frame_LookUp
		ptr frame_Walk11
		ptr frame_Walk12
		ptr frame_Walk13
		ptr frame_Walk14
		ptr frame_Walk15
		ptr frame_Walk16
		ptr frame_Walk21
		ptr frame_Walk22
		ptr frame_Walk23
		ptr frame_Walk24
		ptr frame_Walk25
		ptr frame_Walk26
		ptr frame_Walk31
		ptr frame_Walk32
		ptr frame_Walk33
		ptr frame_Walk34
		ptr frame_Walk35
		ptr frame_Walk36
		ptr frame_Walk41
		ptr frame_Walk42
		ptr frame_Walk43
		ptr frame_Walk44
		ptr frame_Walk45
		ptr frame_Walk46
		ptr frame_Run11
		ptr frame_Run12
		ptr frame_Run13
		ptr frame_Run14
		ptr frame_Run21
		ptr frame_Run22
		ptr frame_Run23
		ptr frame_Run24
		ptr frame_Run31
		ptr frame_Run32
		ptr frame_Run33
		ptr frame_Run34
		ptr frame_Run41
		ptr frame_Run42
		ptr frame_Run43
		ptr frame_Run44
		ptr frame_Roll1
		ptr frame_Roll2
		ptr frame_Roll3
		ptr frame_Roll4
		ptr frame_Roll5
		ptr frame_Stop1
		ptr frame_Stop2
		ptr frame_Duck
		ptr frame_Balance1
		ptr frame_Balance2
		ptr frame_Float1
		ptr frame_Float2
		ptr frame_Float3
		ptr frame_Spring
		ptr frame_Hang1
		ptr frame_Hang2
		ptr frame_Push1
		ptr frame_Push2
		ptr frame_Push3
		ptr frame_Push4
		ptr frame_Drown
		ptr frame_Death
		ptr frame_Float5
		ptr frame_Float6
		ptr frame_Injury
		ptr frame_GetAir
		ptr frame_WaterSlide

frame_Stand:	spritemap
		piece	-$10, -$14, 3x1, 0
		piece	-$10, -$C, 4x2, 3
		piece	-$10, 4, 3x1, $B
		piece	-8, $C, 3x1, $E
		endsprite
SonPLC_frame_Stand:
		dc.b (@end-SonPLC_frame_Stand-1)/2
		dc.w $2000, $7003, $200B, $200E
	@end:

frame_Wait1:	spritemap
		piece	-$10, -$14, 3x2, 0
		piece	-$10, -4, 3x2, 6
		piece	-8, $C, 3x1, $C
		endsprite
SonPLC_frame_Wait1:
		dc.b (@end-SonPLC_frame_Wait1-1)/2
		dc.w $5011, $5017, $201D
	@end:

frame_Wait2:	spritemap
		piece	-$10, -$14, 3x2, 0
		piece	-$10, -4, 3x2, 6
		piece	-8, $C, 3x1, $C
		endsprite
SonPLC_frame_Wait2:
		dc.b (@end-SonPLC_frame_Wait2-1)/2
		dc.w $5020, $5017, $201D
	@end:

frame_Wait3:	spritemap
		piece	-$10, -$14, 3x2, 0
		piece	-$10, -4, 3x2, 6
		piece	-8, $C, 3x1, $C
		endsprite
SonPLC_frame_Wait3:
		dc.b (@end-SonPLC_frame_Wait3-1)/2
		dc.w $5020, $5017, $2026
	@end:

frame_LookUp:	spritemap
		piece	-$10, -$14, 3x3, 0
		piece	-$10, 4, 3x1, 9
		piece	-8, $C, 3x1, $C
		endsprite
SonPLC_frame_LookUp:
		dc.b (@end-SonPLC_frame_LookUp-1)/2
		dc.w $8029, $200B, $200E
	@end:

frame_Walk11:	spritemap
		piece	-$14, -$15, 4x2, 0
		piece	-$14, -5, 3x2, 8
		piece	4, -5, 2x3, $E
		piece	-$14, $B, 2x1, $14
		endsprite
SonPLC_frame_Walk11:
		dc.b (@end-SonPLC_frame_Walk11-1)/2
		dc.w $7032, $503A, $5040, $1046
	@end:

frame_Walk12:	spritemap
		piece	-$13, -$14, 4x2, 0
		piece	-$B, -4, 4x3, 8
		endsprite
SonPLC_frame_Walk12:
		dc.b (@end-SonPLC_frame_Walk12-1)/2
		dc.w $7032, $B048
	@end:

frame_Walk13:	spritemap
		piece	-$D, -$13, 3x2, 0
		piece	-$D, -3, 3x3, 6
		endsprite
SonPLC_frame_Walk13:
		dc.b (@end-SonPLC_frame_Walk13-1)/2
		dc.w $5054, $805A
	@end:

frame_Walk14:	spritemap
		piece	-$C, -$15, 3x2, 0
		piece	-$14, -5, 3x2, 6
		piece	4, -5, 2x3, $C
		piece	-$14, $B, 2x1, $12
		endsprite
SonPLC_frame_Walk14:
		dc.b (@end-SonPLC_frame_Walk14-1)/2
		dc.w $5054, $5063, $5069, $106F
	@end:

frame_Walk15:	spritemap
		piece	-$D, -$14, 3x2, 0
		piece	-$15, -4, 4x3, 6
		endsprite
SonPLC_frame_Walk15:
		dc.b (@end-SonPLC_frame_Walk15-1)/2
		dc.w $5054, $B071
	@end:

frame_Walk16:	spritemap
		piece	-$14, -$13, 4x2, 0
		piece	-$C, -3, 4x1, 8
		piece	-$C, 5, 3x2, $C
		endsprite
SonPLC_frame_Walk16:
		dc.b (@end-SonPLC_frame_Walk16-1)/2
		dc.w $7032, $307D, $5081
	@end:

frame_Walk21:	spritemap
		piece	-$15, -$15, 3x2, 0
		piece	3, -$15, 2x3, 6
		piece	-$15, -5, 3x1, $C
		piece	-$D, 3, 3x2, $F
		piece	-5, $13, 1x1, $15
		endsprite
SonPLC_frame_Walk21:
		dc.b (@end-SonPLC_frame_Walk21-1)/2
		dc.w $5087, $508D, $2093, $5096, $009C
	@end:

frame_Walk22:	spritemap
		piece	-$14, -$14, 3x2, 0
		piece	4, -$14, 1x2, 6
		piece	-$14, -4, 4x1, 8
		piece	-$C, 4, 3x2, $C
		piece	$C, -4, 2x2, $12
		piece	$14, -$C, 1x1, $16
		endsprite
SonPLC_frame_Walk22:
		dc.b (@end-SonPLC_frame_Walk22-1)/2
		dc.w $5087, $109D, $309F, $50A3, $30A9, $00AD
	@end:

frame_Walk23:	spritemap
		piece	-$13, -$13, 3x2, 0
		piece	5, -$13, 1x2, 6
		piece	-$B, -3, 4x2, 8
		piece	-3, $D, 3x1, $10
		endsprite
SonPLC_frame_Walk23:
		dc.b (@end-SonPLC_frame_Walk23-1)/2
		dc.w $50AE, $10B4, $70B6, $20BE
	@end:

frame_Walk24:	spritemap
		piece	-$15, -$15, 3x2, 0
		piece	3, -$15, 2x2, 6
		piece	-$D, -5, 4x2, $A
		piece	-$D, $B, 3x1, $12
		piece	-5, $13, 2x1, $15
		endsprite
SonPLC_frame_Walk24:
		dc.b (@end-SonPLC_frame_Walk24-1)/2
		dc.w $50C1, $30C7, $70CB, $20D3, $10D6
	@end:

frame_Walk25:	spritemap
		piece	-$14, -$14, 3x2, 0
		piece	4, -$14, 1x2, 6
		piece	-$C, -4, 4x2, 8
		piece	-4, $C, 3x1, $10
		endsprite
SonPLC_frame_Walk25:
		dc.b (@end-SonPLC_frame_Walk25-1)/2
		dc.w $50C1, $10D8, $70DA, $20E2
	@end:

frame_Walk26:	spritemap
		piece	-$13, -$13, 3x2, 0
		piece	5, -$13, 1x2, 6
		piece	-$13, -3, 1x1, 8
		piece	-$B, -3, 4x2, 9
		piece	-3, $D, 3x1, $11
		endsprite
SonPLC_frame_Walk26:
		dc.b (@end-SonPLC_frame_Walk26-1)/2
		dc.w $5087, $109D, $0093, $70E5, $20ED
	@end:

frame_Walk31:	spritemap
		piece	-$15, -$C, 2x4, 0
		piece	-5, -$14, 3x2, 8
		piece	-5, -4, 2x1, $E
		piece	-5, 4, 3x2, $10
		endsprite
SonPLC_frame_Walk31:
		dc.b (@end-SonPLC_frame_Walk31-1)/2
		dc.w $70F0, $50F8, $10FE, $5100
	@end:

frame_Walk32:	spritemap
		piece	-$14, -$C, 2x4, 0
		piece	-4, -$14, 3x4, 8
		endsprite
SonPLC_frame_Walk32:
		dc.b (@end-SonPLC_frame_Walk32-1)/2
		dc.w $70F0, $B106
	@end:

frame_Walk33:	spritemap
		piece	-$13, -$C, 2x3, 0
		piece	-3, -$C, 3x3, 6
		endsprite
SonPLC_frame_Walk33:
		dc.b (@end-SonPLC_frame_Walk33-1)/2
		dc.w $5112, $8118
	@end:

frame_Walk34:	spritemap
		piece	-$15, -$C, 2x3, 0
		piece	-5, -$14, 3x2, 6
		piece	-5, -4, 2x1, $C
		piece	-5, 4, 3x2, $E
		endsprite
SonPLC_frame_Walk34:
		dc.b (@end-SonPLC_frame_Walk34-1)/2
		dc.w $5112, $5121, $1127, $5129
	@end:

frame_Walk35:	spritemap
		piece	-$14, -$C, 2x3, 0
		piece	-4, -$C, 3x4, 6
		endsprite
SonPLC_frame_Walk35:
		dc.b (@end-SonPLC_frame_Walk35-1)/2
		dc.w $5112, $B12F
	@end:

frame_Walk36:	spritemap
		piece	-$13, -$C, 2x4, 0
		piece	-3, -$14, 1x1, 8
		piece	-3, -$C, 3x3, 9
		endsprite
SonPLC_frame_Walk36:
		dc.b (@end-SonPLC_frame_Walk36-1)/2
		dc.w $70F0, $0106, $813B
	@end:

frame_Walk41:	spritemap
		piece	-$15, -3, 2x3, 0
		piece	-$D, -$13, 2x1, 6
		piece	-$15, -$B, 2x1, 8
		piece	-5, -$B, 3x3, $A
		piece	-5, $D, 1x1, $13
		piece	$13, -3, 1x1, $14
		endsprite
SonPLC_frame_Walk41:
		dc.b (@end-SonPLC_frame_Walk41-1)/2
		dc.w $5144, $114A, $114C, $814E, $0157, $0158
	@end:

frame_Walk42:	spritemap
		piece	-$14, -4, 2x3, 0
		piece	-$C, -$1C, 3x1, 6
		piece	-4, -$14, 2x1, 9
		piece	-$14, -$C, 2x1, $B
		piece	-4, -$C, 3x3, $D
		piece	-4, $C, 1x1, $16
		endsprite
SonPLC_frame_Walk42:
		dc.b (@end-SonPLC_frame_Walk42-1)/2
		dc.w $5144, $2159, $115C, $115E, $8160, $0157
	@end:

frame_Walk43:	spritemap
		piece	-$13, -5, 2x3, 0
		piece	-$13, -$D, 2x1, 6
		piece	-3, -$15, 3x3, 8
		piece	-3, 3, 2x1, $11
		endsprite
SonPLC_frame_Walk43:
		dc.b (@end-SonPLC_frame_Walk43-1)/2
		dc.w $5169, $116F, $8171, $117A
	@end:

frame_Walk44:	spritemap
		piece	-$15, -3, 2x3, 0
		piece	-$D, -$13, 3x1, 6
		piece	-$15, -$B, 2x1, 9
		piece	-5, -$B, 4x2, $B
		piece	-5, 5, 3x1, $13
		endsprite
SonPLC_frame_Walk44:
		dc.b (@end-SonPLC_frame_Walk44-1)/2
		dc.w $517C, $2182, $1185, $7187, $218F
	@end:

frame_Walk45:	spritemap
		piece	-$14, -4, 2x3, 0
		piece	-$14, -$C, 2x1, 6
		piece	-4, -$14, 3x3, 8
		piece	-4, 4, 2x1, $11
		endsprite
SonPLC_frame_Walk45:
		dc.b (@end-SonPLC_frame_Walk45-1)/2
		dc.w $517C, $1192, $8194, $119D
	@end:

frame_Walk46:	spritemap
		piece	-$13, -5, 2x3, 0
		piece	-3, -$15, 3x3, 6
		piece	-$13, -$D, 2x1, $F
		piece	-3, 3, 2x1, $11
		piece	-3, $B, 1x1, $13
		endsprite
SonPLC_frame_Walk46:
		dc.b (@end-SonPLC_frame_Walk46-1)/2
		dc.w $5144, $819F, $115E, $11A8, $0157
	@end:

frame_Run11:	spritemap
		piece	-$C, -$12, 3x2, 0
		piece	-$14, -2, 4x3, 6
		endsprite
SonPLC_frame_Run11:
		dc.b (@end-SonPLC_frame_Run11-1)/2
		dc.w $51AA, $B1B0
	@end:

frame_Run12:	spritemap
		piece	-$C, -$12, 3x2, 0
		piece	-$14, -2, 4x3, 6
		endsprite
SonPLC_frame_Run12:
		dc.b (@end-SonPLC_frame_Run12-1)/2
		dc.w $5054, $B1BC
	@end:

frame_Run13:	spritemap
		piece	-$C, -$12, 3x2, 0
		piece	-$14, -2, 4x3, 6
		endsprite
SonPLC_frame_Run13:
		dc.b (@end-SonPLC_frame_Run13-1)/2
		dc.w $51AA, $B1C8
	@end:

frame_Run14:	spritemap
		piece	-$C, -$12, 3x2, 0
		piece	-$14, -2, 4x3, 6
		endsprite
SonPLC_frame_Run14:
		dc.b (@end-SonPLC_frame_Run14-1)/2
		dc.w $5054, $B1D4
	@end:

frame_Run21:	spritemap
		piece	-$12, -$12, 3x2, 0
		piece	6, -$12, 1x2, 6
		piece	-$A, -2, 4x3, 8
		piece	-$12, -2, 1x1, $14
		endsprite
SonPLC_frame_Run21:
		dc.b (@end-SonPLC_frame_Run21-1)/2
		dc.w $51E0, $11E6, $B1E8, $01F4
	@end:

frame_Run22:	spritemap
		piece	-$12, -$12, 3x2, 0
		piece	6, -$12, 1x2, 6
		piece	-$A, -2, 4x3, 8
		endsprite
SonPLC_frame_Run22:
		dc.b (@end-SonPLC_frame_Run22-1)/2
		dc.w $51F5, $11FB, $B1FD
	@end:

frame_Run23:	spritemap
		piece	-$12, -$12, 3x2, 0
		piece	6, -$12, 1x2, 6
		piece	-$A, -2, 4x3, 8
		piece	-$12, -2, 1x1, $14
		endsprite
SonPLC_frame_Run23:
		dc.b (@end-SonPLC_frame_Run23-1)/2
		dc.w $51E0, $1209, $B20B, $01F4
	@end:

frame_Run24:	spritemap
		piece	-$12, -$12, 3x2, 0
		piece	6, -$12, 1x2, 6
		piece	-$A, -2, 4x3, 8
		endsprite
SonPLC_frame_Run24:
		dc.b (@end-SonPLC_frame_Run24-1)/2
		dc.w $51F5, $11FB, $B217
	@end:

frame_Run31:	spritemap
		piece	-$12, -$C, 2x3, 0
		piece	-2, -$C, 3x4, 6
		endsprite
SonPLC_frame_Run31:
		dc.b (@end-SonPLC_frame_Run31-1)/2
		dc.w $5223, $B229
	@end:

frame_Run32:	spritemap
		piece	-$12, -$C, 2x3, 0
		piece	-2, -$C, 3x4, 6
		endsprite
SonPLC_frame_Run32:
		dc.b (@end-SonPLC_frame_Run32-1)/2
		dc.w $5112, $B235
	@end:

frame_Run33:	spritemap
		piece	-$12, -$C, 2x3, 0
		piece	-2, -$C, 3x4, 6
		endsprite
SonPLC_frame_Run33:
		dc.b (@end-SonPLC_frame_Run33-1)/2
		dc.w $5223, $B241
	@end:

frame_Run34:	spritemap
		piece	-$12, -$C, 2x3, 0
		piece	-2, -$C, 3x4, 6
		endsprite
SonPLC_frame_Run34:
		dc.b (@end-SonPLC_frame_Run34-1)/2
		dc.w $5112, $B24D
	@end:

frame_Run41:	spritemap
		piece	-$12, -6, 2x3, 0
		piece	-$12, -$E, 2x1, 6
		piece	-2, -$16, 3x4, 8
		piece	-2, $A, 1x1, $14
		endsprite
SonPLC_frame_Run41:
		dc.b (@end-SonPLC_frame_Run41-1)/2
		dc.w $5259, $125F, $B261, $026D
	@end:

frame_Run42:	spritemap
		piece	-$12, -$E, 2x4, 0
		piece	-2, -$16, 3x4, 8
		endsprite
SonPLC_frame_Run42:
		dc.b (@end-SonPLC_frame_Run42-1)/2
		dc.w $726E, $B276
	@end:

frame_Run43:	spritemap
		piece	-$12, -6, 2x3, 0
		piece	-$12, -$E, 2x1, 6
		piece	-2, -$16, 3x4, 8
		piece	-2, $A, 1x1, $14
		endsprite
SonPLC_frame_Run43:
		dc.b (@end-SonPLC_frame_Run43-1)/2
		dc.w $5259, $1282, $B284, $026D
	@end:

frame_Run44:	spritemap
		piece	-$12, -$E, 2x4, 0
		piece	-2, -$16, 3x4, 8
		endsprite
SonPLC_frame_Run44:
		dc.b (@end-SonPLC_frame_Run44-1)/2
		dc.w $726E, $B290
	@end:

frame_Roll1:	spritemap
		piece	-$10, -$10, 4x4, 0
		endsprite
SonPLC_frame_Roll1:
		dc.b (@end-SonPLC_frame_Roll1-1)/2
		dc.w $F29C
	@end:

frame_Roll2:	spritemap
		piece	-$10, -$10, 4x4, 0
		endsprite
SonPLC_frame_Roll2:
		dc.b (@end-SonPLC_frame_Roll2-1)/2
		dc.w $F2AC
	@end:

frame_Roll3:	spritemap
		piece	-$10, -$10, 4x4, 0
		endsprite
SonPLC_frame_Roll3:
		dc.b (@end-SonPLC_frame_Roll3-1)/2
		dc.w $F2BC
	@end:

frame_Roll4:	spritemap
		piece	-$10, -$10, 4x4, 0
		endsprite
SonPLC_frame_Roll4:
		dc.b (@end-SonPLC_frame_Roll4-1)/2
		dc.w $F2CC
	@end:

frame_Roll5:	spritemap
		piece	-$10, -$10, 4x4, 0
		endsprite
SonPLC_frame_Roll5:
		dc.b (@end-SonPLC_frame_Roll5-1)/2
		dc.w $F2DC
	@end:

frame_Stop1:	spritemap
		piece	-$10, -$13, 3x2, 0
		piece	-$10, -3, 4x3, 6
		endsprite
SonPLC_frame_Stop1:
		dc.b (@end-SonPLC_frame_Stop1-1)/2
		dc.b $52, $EC
	dc.b $B2, $F2
	@end:

frame_Stop2:	spritemap
		piece	-$10, -$13, 3x2, 0
		piece	-$10, -3, 4x2, 6
		piece	0, $D, 2x1, $E
		piece	-$18, 5, 1x1, $10
		endsprite
SonPLC_frame_Stop2:
		dc.b (@end-SonPLC_frame_Stop2-1)/2
		dc.b $52, $FE
	dc.b $73, $4
	dc.b $13, $C
	dc.b $3, $E
	@end:

frame_Duck:	spritemap
		piece	-4, -$C, 2x1, 0
		piece	-$C, -4, 4x2, 2
		piece	-$C, $C, 3x1, $A
		piece	-$14, 4, 1x1, $D
		endsprite
SonPLC_frame_Duck:
		dc.b (@end-SonPLC_frame_Duck-1)/2
		dc.b $13, $F
	dc.b $73, $11
	dc.b $23, $19
	dc.b $3, $1C
	@end:

frame_Balance1:	spritemap
		piece	-$18, -$14, 3x1, 0, xflip
		piece	0, -$C, 1x3, 3, xflip
		piece	-$20, -$C, 4x4, 6, xflip
		endsprite
SonPLC_frame_Balance1:
		dc.b (@end-SonPLC_frame_Balance1-1)/2
		dc.b $23, $1D
	dc.b $23, $20
	dc.b $F3, $23
	@end:

frame_Balance2:	spritemap
		piece	-$18, -$14, 4x3, 0, xflip
		piece	-$20, 4, 4x2, $C, xflip
		piece	0, $C, 1x1, $14, xflip, yflip
		endsprite
SonPLC_frame_Balance2:
		dc.b (@end-SonPLC_frame_Balance2-1)/2
		dc.b $B3, $33
	dc.b $73, $3F
	dc.b $0, $71
	@end:

frame_Float1:	spritemap
		piece	-4, -$C, 4x2, 0
		piece	-$14, -4, 2x2, 8
		piece	-4, 4, 3x1, $C
		endsprite
SonPLC_frame_Float5:
		dc.b (@end-SonPLC_frame_Float5-1)/2
		dc.b $73, $47
	dc.b $33, $4F
	dc.b $23, $53
	@end:

frame_Float2:	spritemap
		piece	-$18, -$C, 3x3, 0
		piece	0, -$C, 3x3, 0, xflip
		endsprite
SonPLC_frame_Float2:
		dc.b (@end-SonPLC_frame_Float2-1)/2
		dc.b $83, $56
	@end:

frame_Float3:	spritemap
		piece	-$1C, -$C, 4x2, 0
		piece	4, -4, 1x1, 8
		piece	-$14, 4, 4x1, 9
		endsprite
SonPLC_frame_Float6:
		dc.b (@end-SonPLC_frame_Float6-1)/2
		dc.b $73, $5F
	dc.b $3, $67
	dc.b $33, $68
	@end:

frame_Spring:	spritemap
		piece	-$10, -$18, 3x4, 0
		piece	-8, 8, 2x1, $C
		piece	-8, $10, 1x1, $E
		endsprite
SonPLC_frame_Spring:
		dc.b (@end-SonPLC_frame_Spring-1)/2
		dc.b $B3, $6C
	dc.b $13, $78
	dc.b $3, $7A
	@end:

frame_Hang1:	spritemap
		piece	-$18, -8, 4x3, 0
		piece	8, 0, 2x2, $C
		piece	8, -8, 1x1, $10
		piece	-8, -$10, 1x1, $11
		endsprite
SonPLC_frame_Hang1:
		dc.b (@end-SonPLC_frame_Hang1-1)/2
		dc.b $B3, $7B
	dc.b $33, $87
	dc.b $3, $8B
	dc.b $3, $8C
	@end:

frame_Hang2:	spritemap
		piece	-$18, -8, 4x3, 0
		piece	8, 0, 2x2, $C
		piece	8, -8, 1x1, $10
		piece	-8, -$10, 1x1, $11
		endsprite
SonPLC_frame_Hang2:
		dc.b (@end-SonPLC_frame_Hang2-1)/2
		dc.b $B3, $8D
	dc.b $33, $99
	dc.b $3, $9D
	dc.b $3, $9E
	@end:

frame_Push1:	spritemap
		piece	-$D, -$13, 3x3, 0
		piece	-$15, 5, 4x2, 9
		endsprite
SonPLC_frame_Push1:
		dc.b (@end-SonPLC_frame_Push1-1)/2
		dc.b $83, $9F
	dc.b $73, $A8
	@end:

frame_Push2:	spritemap
		piece	-$D, -$14, 3x3, 0
		piece	-$D, 4, 3x1, 9
		piece	-$D, $C, 2x1, $C
		endsprite
SonPLC_frame_Push2:
		dc.b (@end-SonPLC_frame_Push2-1)/2
		dc.b $83, $B0
	dc.b $23, $B9
	dc.b $13, $BC
	@end:

frame_Push3:	spritemap
		piece	-$D, -$13, 3x3, 0
		piece	-$15, 5, 4x2, 9
		endsprite
SonPLC_frame_Push3:
		dc.b (@end-SonPLC_frame_Push3-1)/2
		dc.b $83, $BE
	dc.b $73, $C7
	@end:

frame_Push4:	spritemap
		piece	-$D, -$14, 3x3, 0
		piece	-$D, 4, 3x1, 9
		piece	-$D, $C, 2x1, $C
		endsprite
SonPLC_frame_Push4:
		dc.b (@end-SonPLC_frame_Push4-1)/2
		dc.b $83, $B0
	dc.b $23, $CF
	dc.b $13, $D2
	@end:

frame_Drown:	spritemap
		piece	-$14, -$18, 4x2, 0
		piece	$C, -$18, 1x2, 8
		piece	-$C, -8, 3x2, $A
		piece	-$C, 8, 4x1, $10
		piece	-$C, $10, 1x1, $14
		endsprite
SonPLC_frame_Drown:
		dc.b (@end-SonPLC_frame_Drown-1)/2
		dc.b $73, $D4
	dc.b $13, $DC
	dc.b $53, $DE
	dc.b $33, $E4
	dc.b $3, $E8
	@end:

frame_Death:	spritemap
		piece	-$14, -$18, 4x2, 0
		piece	$C, -$18, 1x2, 8
		piece	-$C, -8, 3x2, $A
		piece	-$C, 8, 4x1, $10
		piece	-$C, $10, 1x1, $14
		endsprite
SonPLC_frame_Death:
		dc.b (@end-SonPLC_frame_Death-1)/2
		dc.b $73, $E9
	dc.b $13, $DC
	dc.b $53, $F1
	dc.b $33, $E4
	dc.b $3, $E8
	@end:

frame_Float5:	spritemap
		piece	-$1C, -$C, 4x2, 0, xflip
		piece	4, -4, 2x2, 8, xflip
		piece	-$14, 4, 3x1, $C, xflip
		endsprite

frame_Float6:	spritemap
		piece	-4, -$C, 4x2, 0, xflip
		piece	-$C, -4, 1x1, 8, xflip
		piece	-$C, 4, 4x1, 9, xflip
		endsprite

frame_Injury:	spritemap
		piece	-$14, -$10, 4x3, 0
		piece	$C, -8, 1x2, $C
		piece	-$C, 8, 4x1, $E
		endsprite
SonPLC_frame_Injury:
		dc.b (@end-SonPLC_frame_Injury-1)/2
		dc.b $B3, $F7
	dc.b $14, $3
	dc.b $34, $5
	@end:

frame_GetAir:	spritemap
		piece	-$C, -$15, 3x2, 0
		piece	-$14, -5, 4x3, 6
		piece	$C, 3, 1x2, $12
		endsprite
SonPLC_frame_GetAir:
		dc.b (@end-SonPLC_frame_GetAir-1)/2
		dc.b $54, $9
	dc.b $B4, $F
	dc.b $10, $6D
	@end:

frame_WaterSlide:	spritemap
		piece	-$14, -$10, 4x4, 0
		piece	$C, -8, 1x3, $10
		endsprite
SonPLC_frame_WaterSlide:
		dc.b (@end-SonPLC_frame_WaterSlide-1)/2
		dc.b $F4, $1B
	dc.b $24, $2B
	@end:
		even
