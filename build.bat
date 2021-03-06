@echo off

rem assemble Z80 sound driver
axm68k /m /k /p "sound\DAC Driver.asm", "sound\DAC Driver.unc" >"sound\errors.txt", , "sound\DAC Driver.lst"
type "sound\errors.txt"
IF NOT EXIST "sound\DAC Driver.unc" PAUSE & EXIT 2

rem compress kosinski files
for %%f in ("256x256 Mappings\*.unc") do koscmp "%%f" "256x256 Mappings\%%~nf.kos"
for %%f in ("kosdata\*.unc") do koscmp "%%f" "kosdata\%%~nf.kos"
koscmp "sound\DAC Driver.unc" "sound\DAC Driver.kos"
for %%f in ("Graphics - Compressed\Decompressed\*.bin") do nemcmp "%%f" "Graphics - Compressed\%%~nf.nem"
for %%f in ("16x16 Mappings\*.bin") do enicmp "%%f" "16x16 Mappings\%%~nf.eni"
for %%f in ("Tilemaps\*.bin") do enicmp "%%f" "Tilemaps\%%~nf.eni"
for %%f in ("Special Stage Layouts\*.unc") do koscmp "%%f" "Special Stage Layouts\%%~nf.kos"

rem assemble final rom
IF EXIST s1built.bin move /Y s1built.bin s1built.prev.bin >NUL
axm68k /m /k /p sonic.asm, s1built.bin >errors.txt, , sonic.lst
type errors.txt

rem check for success and fix header
IF NOT EXIST s1built.bin PAUSE & EXIT 2
fixheadr.exe s1built.bin
exit 0
