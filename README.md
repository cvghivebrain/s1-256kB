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
Target | 262144 | 

## Credits

* [Clownacy](https://github.com/Clownacy) for [the accurate Kosinski compressor](https://github.com/Clownacy/accurate-kosinski)
* [flamewing](https://github.com/flamewing) for [mdcomp](https://github.com/flamewing/mdcomp)