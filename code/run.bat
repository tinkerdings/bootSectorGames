@echo off
if "%1"="" goto error
build\%1.com
goto end
:error
echo You must specify a target name.
:end
