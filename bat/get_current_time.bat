
@echo off

rem ----------------------------------------------
rem �ļ���: 
rem 	get_current_time.bat
rem 
rem ˵��:
rem 	��Ҫ���ϵص��øýű��Ի�����µ�����ʱ����Ϣ
rem 	��ȡ��ǰ������Ϣ
rem
rem Usage:
rem 	get_current_time
rem ----------------------------------------------



:: Date
set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

:: Time
:: ���ʱ������10�㣬��Ҫ���һ��
set hh=%time:~0,2%
set mm=%time:~3,2%
set ss=%time:~6,2%
set ms=%time:~9,2%

:: Format
set LONG_DATE=%YEAR%%MONTH%%DAY%
set SHORT_DATE_LONG=%YEAR:~2,2%%MONTH%%DAY%
set SHORT_DATE=%MONTH%%DAY%

:: �˴���������Զ���ĸ�ʽ

:: exit this bat context rather than the cmd env.
:: errorlevel = 0
exit /b 0
