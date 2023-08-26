@echo off
if "%1"="" goto error
type listing\%1.lst
goto end
:error
echo You must specify a listing name.
:end
