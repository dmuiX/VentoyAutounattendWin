@echo off

:: don't run this twice!
:: if exist %systemroot%\DONE_SDI.tag exit

:: set USB and location Dir
set USB=%~d0
set FILEDIR=%USB%\SetupComplete\
set SETUPDIR=%WINDIR%\SETUP\
set SETUPFILES=%SETUPDIR%\SetupFiles\
set PRESETUPDIR=%SETUPDIR%\PreSetup\


:: create Temp folder and set log path
::md %systemdrive%\Temp > nul
set log=%systemdrive%\%~n0.log

:: install Scoop
	::download install.ps1
::Powershell -NoProfile -ExecutionPolicy Bypass -Command "((iex (new-object net.webclient).downloadstring('https://get.scoop.sh')))"
:: %systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://raw.githubusercontent.com/ScoopInstaller/Install/master/install.ps1','%SYSTEMDRIVE%\install.ps1'))"
:: This is working but limited to non admin users!
:: powershell -ExecutionPolicy Bypass -File %SYSTEMDRIVE%\install.ps1 >> %log%

	::run installer
:: Installation of scoop cannot be run with admin rights instead you can use this:
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "((iex '& {$(irm get.scoop.sh)} -RunAsAdmin'))"

::%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& 'irm get.scoop.sh | iex' %*"
::&& ($LASTEXITCODE -eq 0) ? Write-Output >Scoop was installed correctly" >> $ENV:SYSTEMDRIVE/scoop_install.log  : Write-Output "Scoop was not installed correctly" >> $ENV:SYSTEMDRIVE/scoop_install.log
:: push tag to stop
::echo stop > %systemroot%\DONE_SDI.tag

:: echo "Successful executed" >> %log%

pause