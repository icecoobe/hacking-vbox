
rem ---------------------------------------------
rem File Name:
rem 	sleep.bat
rem
rem Usage: 
rem 	sleep [number]
rem 	sleep number seconds
rem
rem See Also:
rem 	timeout [/t] number [/nobreak]
rem 	显示剩余时间的暂停
rem ---------------------------------------------

@echo off

ping 127.0.0.1 -n %1 > nul

:EXIT
rem ## 通过errorlevel来传递返回值
exit /b 0
