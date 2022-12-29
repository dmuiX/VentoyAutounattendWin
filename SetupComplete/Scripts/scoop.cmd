echo %path%|find /i "scoop" > NUL

if %errorlevel% == 0 (

:: md %systemdrive%\Temp > nul
:: set log=%systemdrive%\%~n0.log
set LogFile=%systemdrive%\%~n0.log
set logg=^> _^&type _^&type _^>^>%LogFile

call scoop install git %logg%
call scoop bucket add extras %logg%
call scoop bucket add main %logg%

call scoop install sudo %logg%
call scoop install clink %logg%
clink autorun install %logg%
call scoop install firefox %logg%
call scoop install brave %logg%
call scoop install windows-terminal %logg%

call scoop bucket add anderlli0053_DEV-tools https://github.com/anderlli0053/DEV-tools %logg%
call scoop install HashTab %logg%
call scoop install autodarkmode %logg%
call scoop install itunes-portable %logg%
call scoop install mediainfo %logg%
call scoop install advancedrenamer %logg%
call scoop install vscode %logg%
call scoop install treesize-free %logg%
call scoop install defraggler %logg%
call scoop install vmware-workstation-pro %logg%
)

