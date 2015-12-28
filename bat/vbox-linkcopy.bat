
@echo off

rem ----------------------------------------------
rem �ļ���: 
rem vbox.bat
rem 
rem ˵��:�������������
rem
rem Usage:
rem ---------------------------------------------
:memu
set /a rd=%random%%%23
if %rd% lss 20 goto memu
echo %rd%


if VBOX_MSI_INSTALL_PATH=="" echo VirtualBox not installed!

call setpath.bat
call get_current_time.bat

if not %errorlevel%==0 goto Quit

:: ���������������
set min=1
set max=%rd%
:: ����Ϊ1
set inc=1

:: �������ŵ�·��, �Ե�������ڴ������ļ���
set VMDir="E:\%short_date%"

:: ��ݷ�ʽ��ŵ�Ŀ¼
set ShortcutDir="D:\Zpan\start\vboxkj"

:: 1.ǰ��׼��
::--------------------------------------------------------------------
:: �����Ĳ����������������
::
:: ------ ��  1  �� 23YQ ------
:: ģ����������� 23YQ
vboxmanage clonevm "23YQ" --name "%short_date%-23YQ" --register
:: backup the new VM for creating linked copy
vboxmanage snapshot "%short_date%-23YQ" take "%short_date%-23YQ_backup"

:: ------ ��  2  �� 7654 ------
:: ģ����������� 7654
vboxmanage clonevm "7654" --name "%short_date%-7654" --register
vboxmanage snapshot "%short_date%-7654" take "%short_date%-7654_backup"

:: ------ ��  3  �� LGQB ------
:: ģ����������� LGQB
vboxmanage clonevm "LGQB" --name "%short_date%-LGQB" --register
vboxmanage snapshot "%short_date%-LGQB" take "%short_date%-LGQB_backup"

::--------------------------------------------------------------------


if not %errorlevel%==0 goto Quit
::--------------------------------------------------------------------
:: 2.��������

:: �� 1 �� 23YQ
for /L %%i in (%min%, %inc%, %max%) do (

    echo  ������������� "%short_date%-23YQ-%%i"
    vboxmanage clonevm "%short_date%-23YQ" --snapshot "%short_date%-23YQ_backup" --options link --mode machine --name "%short_date%-23YQ-%%i" --basefolder %VMDir% --register

    echo �����������Ϣ�����壬Ӳ�����кŵ�
    call SetVMInfo.bat  "%short_date%-23YQ-%%i"

    echo �����������ݷ�ʽ��ָ��Ŀ¼
    CreateShortcutForVM.exe %ShortcutDir%  "%short_date%-23YQ-%%i"
)
::--------------------------------------------------------------------

:: �� 2 �� 9EQB
for /L %%i in (%min%, %inc%, %max%) do (

    echo  ������������� "%short_date%-7654-%%i"
    vboxmanage clonevm "%short_date%-7654" --snapshot "%short_date%-7654_backup" --options link --mode machine --name "%short_date%-7654-%%i" --basefolder %VMDir% --register
   

    echo �����������Ϣ�����壬Ӳ�����кŵ�
    call SetVMInfo.bat  "%short_date%-7654-%%i"

    echo �����������ݷ�ʽ��ָ��Ŀ¼
    CreateShortcutForVM.exe %ShortcutDir%  "%short_date%-7654-%%i"
)
::--------------------------------------------------------------------

:: �� 3 �� LGQB
for /L %%i in (%min%, %inc%, %max%) do (

    echo  ������������� "%short_date%-LGQB-%%i"
    vboxmanage clonevm "%short_date%-LGQB" --snapshot "%short_date%-LGQB_backup" --options link --mode machine --name "%short_date%-LGQB-%%i" --basefolder %VMDir% --register

    echo �����������Ϣ�����壬Ӳ�����кŵ�
    call SetVMInfo.bat  "%short_date%-LGQB-%%i"

    echo �����������ݷ�ʽ��ָ��Ŀ¼
    CreateShortcutForVM.exe %ShortcutDir%  "%short_date%-LGQB-%%i"
)

echo.
echo ����%short_date%����������Ƶ������Ѿ����
::--------------------------------------------------------------------
:Quit
    echo last error is %errorlevel%; Ready to quit this bat file
    timeout /t 5
start "" "C:\Program Files\Oracle\VirtualBox\VirtualBox.exe"
timeout /t 60

    exit /b %errorlevel%
::--------------------------------------------------------------------
