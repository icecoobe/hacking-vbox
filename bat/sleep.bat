
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
rem 	��ʾʣ��ʱ�����ͣ
rem ---------------------------------------------

@echo off

ping 127.0.0.1 -n %1 > nul

:EXIT
rem ## ͨ��errorlevel�����ݷ���ֵ
exit /b 0
