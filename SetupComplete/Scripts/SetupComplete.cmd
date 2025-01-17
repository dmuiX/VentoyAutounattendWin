@echo off

:: create Temp folder and set log path
set LogFile=%systemdrive%\%~n0.log
set logg=^> _^&type _^&type _^>^>%LogFile%

echo TEst this goes to screen AND file! %logg%

set SETUPDIR=%SystemRoot%\Setup\
set SETUPFILES=%SETUPDIR%\SetupFiles\

:: Install Office 2021 using Office Tool Plus https://help.coolhub.top/others/commands.html#deploy-commands
::echo Install Office %logg%
::"%SETUPFILES%\Office Tool\Office Tool Plus.Console.exe" deploy /addProduct O365ProPlusRetail_en-us_Publisher,Lync,Access,OneNote /channel Current /clientEdition 64 /acceptEULA
::if errorlevel 0 ( echo Install Office SUCCESS! %logg% )

:: Activate Office and Windows at this place using certain tools
::echo Activate Office %logg%
::start /wait cmd /c %SETUPDIR%\Scripts\activateOffice.cmd
::if errorlevel 0 ( echo Activate Office SUCCESS! %logg% )

:: Add some registry entries
echo Add registry entries %logg%
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v ConfigureStartPins /d '{\"pinnedList\": [{}]}' /t REG_SZ /f
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /d 1 /t REG_DWORD /f
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /d 1 /t REG_DWORD /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v ContentDeliveryAllowed /d 0 /t REG_DWORD /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /d 0 /t REG_DWORD /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\" /v SystemPaneSuggestionsEnabled /d 0 /t REG_DWORD /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v StartupPage /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v AllItemsIconView /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v NavPaneShowAllFolders /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v AutoCheckSelect /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoStartMenuMorePrograms /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoStartMenuMorePrograms /t REG_DWORD /d 0 /f
if errorlevel 0 ( echo Add registry entries SUCCESS! %logg% )

:: Run Decrapifier Script
echo Run Decrapifier Script %logg%
SET PowerShellScriptPath=%SETUPDIR%\Scripts\decrapifier.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File """"%PowerShellScriptPath%"""" -ClearStart' -Verb RunAs;}"
timeout 360
if errorlevel 0 ( echo Run Decrapifier Script SUCCESS! %logg% )

:: Deinstall OneDrive
echo Deinstall OneDrive %logg%
taskkill /f /im OneDrive.exe
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
if errorlevel 0 ( echo Deinstall OneDrive SUCCESS! %logg% )

:: Deinstall Teams
echo Deinstall Teams %logg%
wmic product where name="Teams Machine-Wide Installer" call uninstall
if errorlevel 0 ( echo Deinstall Teams SUCCESS! %logg% )

:: Install Apps using scoop
:: echo Install Apps using scoop %logg%
:: start /wait cmd /c %SETUPDIR%\Scripts\scoop.cmd
:: if errorlevel 0 ( echo Install Apps using scoop SUCCESS! %logg% )

:: Install Apps using Choco
start /wait cmd /c %SETUPDIR%\Scripts\choco.cmd

:: Clean up
:: if exist "%SETUPDIR%\Ninite.exe" @DEL /S /Q "%SETUPDIR%\Ninite.exe"
:: if exist "%SETUPFILES%" @RD /S /Q "%SETUPFILES%"
:: if exist "%SETUPDIR%\PreSetup\" @RD /S /Q "%SETUPDIR%\PreSetup\"
:: if exist "%SETUPDIR%\Scripts\" @RD /S /Q "%SETUPDIR%\Scripts\"

pause
:: Reboot
shutdown /r /t 15

::exit /b