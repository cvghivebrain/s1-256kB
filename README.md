# Sonic the Hedgehog in 256kB

Can I get Sonic the Hedgehog to fit into 256kB?

## Rules

* Must be hardware compatible.
* Normal gameplay must appear the same. Debug mode can go.
* Extra loading time is allowed.

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
Target | 262144 | 

## Credits

* [Clownacy](https://github.com/Clownacy) for [the accurate Kosinski compressor](https://github.com/Clownacy/accurate-kosinski)
* [flamewing](https://github.com/flamewing) for [mdcomp](https://github.com/flamewing/mdcomp)