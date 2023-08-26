@echo off
if "%1"=="" goto error
dosbox build\%1.com
goto end
:error
echo You must specify a target name.
:end
