@echo off

:rand_str
Setlocal Enabledelayedexpansion
set Str=0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ
set /a 长度=%1
set "result="
for /l %%i in (1,1,8888) do (if "!Str:~0,%%i!"=="!Str!" set StrSum=%%i&goto :resultproc)
:resultproc
set /a Num+=1,StrNum=%Random%%%%StrSum%
set "result=%result%!str:~%StrNum%,1!"
if not %Num% == %长度% goto :resultproc
endlocal&set "%~2=%result%"
goto :eof