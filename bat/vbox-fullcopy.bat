
@echo off

rem ----------------------------------------------
rem 文件名: 
rem vbox.bat
rem 
rem 说明:完整复制虚拟机
rem
rem Usage:
rem ---------------------------------------------



if VBOX_MSI_INSTALL_PATH=="" echo VirtualBox not installed!

call setpath.bat
call get_current_time.bat

if not %errorlevel%==0 goto Quit

:: 虚拟机的数量设置
set min=1
set max=100
:: 增幅为1
set inc=1

:: 虚拟机存放的路径, 以当天的日期创建的文件夹
set VMDir="E:\%short_date%"

:: 快捷方式存放的目录
set ShortcutDir="D:\Zpan\start\vboxkj"

:: 1.前期准备
::--------------------------------------------------------------------
:: 后续的参照这个添加组就行了
::
:: ------ 第  1  组 23YQ ------
:: 模板虚拟机名称 23YQ
vboxmanage clonevm "23YQ" --name "%short_date%-23YQ" --register

:: ------ 第  2  组 9EQB ------
:: 模板虚拟机名称 9EQB
vboxmanage clonevm "9EQB" --name "%short_date%-9EQB" --register

:: ------ 第  3  组 LGQB ------
:: 模板虚拟机名称 LGQB
vboxmanage clonevm "LGQB" --name "%short_date%-LGQB" --register

::--------------------------------------------------------------------


if not %errorlevel%==0 goto Quit
::--------------------------------------------------------------------
:: 2.批量复制

:: 第 1 组 23YQ
for /L %%i in (%min%, %inc%, %max%) do (

    echo  复制生成虚拟机 "%short_date%-23YQ-%%i"
    vboxmanage clonevm "%short_date%-23YQ"  --mode machine --name "%short_date%-23YQ-%%i" --basefolder %VMDir% --register

    echo 更改虚拟机信息，主板，硬盘序列号等
    call SetVMInfo.bat  "%short_date%-23YQ-%%i"

    echo 创建虚拟机快捷方式到指定目录
    CreateShortcutForVM.exe %ShortcutDir%  "%short_date%-23YQ-%%i"
)
::--------------------------------------------------------------------

:: 第 2 组 9EQB
for /L %%i in (%min%, %inc%, %max%) do (

    echo  复制生成虚拟机 "%short_date%-9EQB-%%i"
    vboxmanage clonevm "%short_date%-9EQB"  --mode machine --name "%short_date%-9EQB-%%i" --basefolder %VMDir% --register
   

    echo 更改虚拟机信息，主板，硬盘序列号等
    call SetVMInfo.bat  "%short_date%-9EQB-%%i"

    echo 创建虚拟机快捷方式到指定目录
    CreateShortcutForVM.exe %ShortcutDir%  "%short_date%-9EQB-%%i"
)
::--------------------------------------------------------------------

:: 第 3 组 LGQB
for /L %%i in (%min%, %inc%, %max%) do (

    echo  复制生成虚拟机 "%short_date%-LGQB-%%i"
    vboxmanage clonevm "%short_date%-LGQB"  --mode machine --name "%short_date%-LGQB-%%i" --basefolder %VMDir% --register

    echo 更改虚拟机信息，主板，硬盘序列号等
    call SetVMInfo.bat  "%short_date%-LGQB-%%i"

    echo 创建虚拟机快捷方式到指定目录
    CreateShortcutForVM.exe %ShortcutDir%  "%short_date%-LGQB-%%i"
)

echo.
echo 日期%short_date%的虚拟机复制等任务已经完成
::--------------------------------------------------------------------
:Quit
    echo last error is %errorlevel%; Ready to quit this bat file
    timeout /t 5
    exit /b %errorlevel%
::--------------------------------------------------------------------
