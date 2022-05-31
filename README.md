# Sonic the Hedgehog in 256kB

Can I get Sonic the Hedgehog to fit into 256kB?

## Rules

* Must be hardware compatible.
* Normal gameplay must appear the same. Debug mode can go.
* Extra loading time is allowed.

## Methods

* Removal of unused objects.
  * MZ sideways stomper.
  * Buzz Bomber missile exploding.
  * Mystery switch that triggers when touched.
  * Sonic CD-style special stage entry effect.
  * Blank objects.
* Removal of unused variants of objects.
  * Crabmeat climbing a slope.
  * Flashing button.
  * GHZ swinging ball on chain.
* Removal of unused graphics.
  * Sonic getting a bubble, surfing, leaping, warping, shrinking and burning.
  * GHZ grey totem pole.
  * GHZ rolling ball. The boss only uses 2 frames for its ball.
  * SYZ "let's go" sign.
  * SLZ blinking lightbulbs.
  * Burrobot facing down.
  * Letters in title cards and level select text.
  * Special stage zone signs, 1up and W.
  * Eggman, S and goggles monitors.
* Removal of unused and duplicate level tiles.
* Removal of cheats, except level select.
* Removal of unused code.
* Reorganising duplicate code into subroutines.
* More and better compression.
  * Replacing stock compression with mdcomp.
  * Kosinski compression replaces Nemesis compression where possible.
  * Graphics that only appear in one zone are consolidated into the main level graphics.
  * Compressed animated graphics by storing them in RAM (much like the flowers from the ending sequence).

## Progress

Description | Size | Difference
----------- | ---- | ----------
Start | 524288 | 0
Removed unused demo, graphics and padding. | 519364 | -4924
Removed unused warp PLC, Special Stage graphics, blank objects. | 518520 | -844
Removed unused objects, temporarily disabled padding for Sega PCM (this will be fixed later). | 516036 | -2484
Removed debug mode and cheat codes. Press A+Start for level select. | 512196 | -3840
Cleaned up some subroutines, removed padding. | 511870 | -326
Used mdcomp for 256x256 mappings. | 508298 | -3572
Removed unused code from batbrain and drowning objects. Used mdcomp for ending flowers. | 508200 | -98
Used mdcomp for Nemesis graphics. | 504518 | -3682
Used mdcomp for 16x16 mappings. | 503240 | -1278
Removed unused code and sprites from some objects. | 501836 | -1404
Removed more unused code and sprites. Compressed giant ring graphics (causes a brief visual glitch when it appears). | 498656 | -3180
Cleaned up more objects. | 498484 | -172
Used mdcomp for tilemaps. | 498366 | -118
Cleaned up MZ objects and monitors. | 497666 | -700
Cleaned up SBZ objects, rings, prison capsule. | 496620 | -1046
Cleaned up SLZ objects. | 496386 | -234
Removed unused Sonic sprites and animations. | 488924 | -7462
Used single index for Sonic's mappings and DPLCs. | 488810 | -114
Cleaned up SYZ objects. | 488506 | -304
Cleaned up title cards and title screen. TM is now part of the logo instead of its own object. | 487792 | -714
Removed unused tiles from MZ/LZ/SLZ. | 483504 | -4288
Removed unused tiles from GHZ/SYZ/SBZ. | 481712 | -1792
Cleaned up Sonic and boss objects. | 481090 | -622
Compressed animated level graphics and replaced hardcoded routines with scripts. | 475530 | -5560
Removed unused code. Fixed bug where animated graphics weren't loaded until after the title card. | 474628 | -902
Compressed HUD graphics. | 473734 | -894
Removed unused code and pointers. | 472670 | -1064
Compressed title screen graphics and removed unused text characters. Added Kosinski-based PLC routine. | 471758 | -912
Kosinski compression for level graphics and some other things. | 457982 | -13776
Compressed some GHZ graphics. | 457152 | -830
Compressed MZ/SYZ graphics. Fixed title screen glitch and altered level select. | 456580 | -572
Kosinski compression for special stages. Removed unused special stage code. | 454012 | -2568
Better compression for DAC driver. Moved Sega PCM to start of ROM so it's always in a $8000 bank. | 453910 | -102
Compressed LZ/SLZ graphics. | 451908 | -2002
Compressed SBZ graphics. Removed unused MZ palette. | 450426 | -1482
Tidied GHZ/MZ/SYZ graphics. | 450230 | -196
Compressed Special Stage graphics. | 449592 | -638
Added ClearRAM subroutine instead of manually clearing sections of RAM. | 449386 | -206
Added SetupObject subroutine to initialise OST values with a script. | 449170 | -216
Used SetupObject for more objects. | 448328 | -842
Extended SetupObject functionality. | 448174 | -154
Target | 262144 | 

## Credits

* [flamewing](https://github.com/flamewing) for [mdcomp](https://github.com/flamewing/mdcomp)