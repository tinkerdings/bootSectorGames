@echo off
if "%1"="" goto error
nasm -f bin %1.asm -l listing\%1.lst -o build\%1.com
goto end
:error
echo You must specify a build target.
:end
