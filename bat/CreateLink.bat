:: "C:\Program Files\Oracle\VirtualBox\VirtualBox.exe" --comment "DemoVM" --startvm "14258dcc-c2cd-4f5f-b758-cd2ab1c100aa"

@echo off 

del tmp.vbs /s /q 
cls 
color 0a 
title 建立快捷方式 

set LnkDir=C:\Users\xx\Desktop\lnk
if not exist %LnkDir% (
	echo 目录%LnkDir%不存在, 正在创建 ...
	mkdir %LnkDir%
)

set TargetFileName="%VBOX_MSI_INSTALL_PATH%VirtualBox.exe"
set VMName=DemoVM

set  shortCutPath="%LnkDir%\%VMName%.lnk"
echo Dim WshShell,Shortcut >> tmp.vbs 
echo Dim fso >> tmp.vbs 
echo Set fso=CreateObject("Scripting.FileSystemObject") >> tmp.vbs 
echo Set WshShell=WScript.CreateObject("WScript.Shell") >> tmp.vbs 
echo Set Shortcut=WshShell.CreateShortCut(%shortCutPath%) >> tmp.vbs 
echo Shortcut.TargetPath="%TargetFileName% --comment "%VMName%" --startvm "%VMName%"" >> tmp.vbs 
echo Shortcut.IconLocation="%TargetFileName%, 2" >> tmp.vbs
echo shortcut.Workingdirectory="%VBOX_MSI_INSTALL_PATH%" >> tmp.vbs
echo Shortcut.Save >> tmp.vbs 

"%SystemRoot%\System32\WScript.exe" tmp.vbs 


del tmp.vbs /s /q 
