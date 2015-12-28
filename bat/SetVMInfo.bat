@echo off

:: ---------------------
:: usage
:: xx.bat vmname
:: ---------------------


set vmname=%1
set vboxman="%VBOX_MSI_INSTALL_PATH%\vboxmanage.exe"
set vmscfgdir=D:\VBOX\ROM\

:: 定义uuid和序列号变量
set "id=ss"
set "serial="

:: DMI BIOS information
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiBIOSVendor"        "Dell Computer Corporation"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiBIOSVersion"       "A12"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiBIOSReleaseDate"   "08/26/2004"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiBIOSReleaseMajor"  2
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiBIOSReleaseMinor"  3
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiBIOSFirmwareMajor" 2
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiBIOSFirmwareMinor" 3

:: DMI system information
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiSystemVendor"			"Dell Computer Corporation"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiSystemProduct"		"Dimension 4600i"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiSystemVersion"		"1.0"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiSystemSerial"			"JTGL999"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiSystemSKU"			"FM550EA#ACB"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiSystemFamily"			"X86-based PC"

call guid.bat id
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiSystemUuid"			%id%

:: DMI board information
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiBoardVendor"			"Gigabyte Technology Co., Ltd."
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiBoardProduct"			"B75M-D3V"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiBoardVersion"			"4.5"

:: 20是长度，不要去改变
call randstr 20 serial
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiBoardSerial"			%serial%

%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiBoardAssetTag"		"Base Board Asset Tag#"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiBoardLocInChass"		"Board Loc In"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiBoardBoardType"		10

:: DMI OEM strings
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiOEMVBoxVer" "Extended version info: 1.00.00"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/DmiOEMVBoxRev" "Extended revision info: 1A"

:: IDE
%vboxman% setextradata %vmname% "VBoxInternal/Devices/piix3ide/0/Config/PrimaryMaster/ModelNumber" "Hitachi HTS543232A7A384"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/piix3ide/0/Config/PrimaryMaster/FirmwareRevision" "ES2OA60W"

:: 长度16
call randstr 16 serial
%vboxman% setextradata %vmname% "VBoxInternal/Devices/piix3ide/0/Config/PrimaryMaster/SerialNumber"  %serial%

%vboxman% setextradata %vmname% "VBoxInternal/Devices/piix3ide/0/Config/SecondaryMaster/ModelNumber" "Slimtype DVD ADS8A8SH"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/piix3ide/0/Config/SecondaryMaster/FirmwareRevision" "KAA2"

:: 长度16
call randstr 16 serial
%vboxman% setextradata %vmname% "VBoxInternal/Devices/piix3ide/0/Config/SecondaryMaster/SerialNumber" %serial%

:: 更新MAC地址
set macaddr=""
call mac.bat macaddr
%vboxman% modifyvm "%1" --macaddress1 %macaddr%

:: 硬件信息补丁
%vboxman% setextradata %vmname% "VBoxInternal/Devices/acpi/0/Config/DsdtFilePath" "%vmscfgdir%ACPI-DSDT.bin"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/acpi/0/Config/SsdtFilePath" "%vmscfgdir%ACPI-SSDT1.bin"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/vga/0/Config/BiosRom" "%vmscfgdir%videorom.bin"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/BiosRom" "%vmscfgdir%pcbios.bin"
%vboxman% setextradata %vmname% "VBoxInternal/Devices/pcbios/0/Config/LanBootRom" "%vmscfgdir%pxerom.bin"

echo 更改虚拟机信息完成！
timeout /t 5
exit /b 0

:badparam
echo.更改虚拟机主板信息等，发生错误，参数不足没有指明虚拟机名称！
timeout /t 5
exit /b 0
