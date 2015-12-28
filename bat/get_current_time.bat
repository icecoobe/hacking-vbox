
@echo off

rem ----------------------------------------------
rem 文件名: 
rem 	get_current_time.bat
rem 
rem 说明:
rem 	需要不断地调用该脚本以获得最新的日期时间信息
rem 	获取当前日期信息
rem
rem Usage:
rem 	get_current_time
rem ----------------------------------------------



:: Date
set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

:: Time
:: 如果时间早于10点，需要解决一下
set hh=%time:~0,2%
set mm=%time:~3,2%
set ss=%time:~6,2%
set ms=%time:~9,2%

:: Format
set LONG_DATE=%YEAR%%MONTH%%DAY%
set SHORT_DATE_LONG=%YEAR:~2,2%%MONTH%%DAY%
set SHORT_DATE=%MONTH%%DAY%

:: 此处继续添加自定义的格式

:: exit this bat context rather than the cmd env.
:: errorlevel = 0
exit /b 0
