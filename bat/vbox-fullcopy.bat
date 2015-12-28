
@echo off

rem ----------------------------------------------
rem �ļ���: 
rem vbox.bat
rem 
rem ˵��:�������������
rem
rem Usage:
rem ---------------------------------------------



if VBOX_MSI_INSTALL_PATH=="" echo VirtualBox not installed!

call setpath.bat
call get_current_time.bat

if not %errorlevel%==0 goto Quit

:: ���������������
set min=1
set max=100
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

:: ------ ��  2  �� 9EQB ------
:: ģ����������� 9EQB
vboxmanage clonevm "9EQB" --name "%short_date%-9EQB" --register

:: ------ ��  3  �� LGQB ------
:: ģ����������� LGQB
vboxmanage clonevm "LGQB" --name "%short_date%-LGQB" --register

::--------------------------------------------------------------------


if not %errorlevel%==0 goto Quit
::--------------------------------------------------------------------
:: 2.��������

:: �� 1 �� 23YQ
for /L %%i in (%min%, %inc%, %max%) do (

    echo  ������������� "%short_date%-23YQ-%%i"
    vboxmanage clonevm "%short_date%-23YQ"  --mode machine --name "%short_date%-23YQ-%%i" --basefolder %VMDir% --register

    echo �����������Ϣ�����壬Ӳ�����кŵ�
    call SetVMInfo.bat  "%short_date%-23YQ-%%i"

    echo �����������ݷ�ʽ��ָ��Ŀ¼
    CreateShortcutForVM.exe %ShortcutDir%  "%short_date%-23YQ-%%i"
)
::--------------------------------------------------------------------

:: �� 2 �� 9EQB
for /L %%i in (%min%, %inc%, %max%) do (

    echo  ������������� "%short_date%-9EQB-%%i"
    vboxmanage clonevm "%short_date%-9EQB"  --mode machine --name "%short_date%-9EQB-%%i" --basefolder %VMDir% --register
   

    echo �����������Ϣ�����壬Ӳ�����кŵ�
    call SetVMInfo.bat  "%short_date%-9EQB-%%i"

    echo �����������ݷ�ʽ��ָ��Ŀ¼
    CreateShortcutForVM.exe %ShortcutDir%  "%short_date%-9EQB-%%i"
)
::--------------------------------------------------------------------

:: �� 3 �� LGQB
for /L %%i in (%min%, %inc%, %max%) do (

    echo  ������������� "%short_date%-LGQB-%%i"
    vboxmanage clonevm "%short_date%-LGQB"  --mode machine --name "%short_date%-LGQB-%%i" --basefolder %VMDir% --register

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
    exit /b %errorlevel%
::--------------------------------------------------------------------
