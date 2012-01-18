@echo off
if not x%1==x goto ok
echo Usage: rasm asm-file
echo    eg: rasm blink.asm
goto done

:ok
c:\6115\rasm51e\rasm51e.exe %1 %2 %3 %4 -o -l -e

:done
