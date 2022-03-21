; ---------------------------------------------------------------------------
; Sprite mappings - smashable green block (MZ)
; ---------------------------------------------------------------------------
Map_Smab:	index *
		ptr frame_smash_four
		
frame_smash_four:
		spritemap					; four fragments
		piece	-$10, -$10, 2x2, 0, hi
		piece	-$10, 0, 2x2, 0, hi
		piece	0, -$10, 2x2, 0, hi
		piece	0, 0, 2x2, 0, hi
		endsprite
		even
