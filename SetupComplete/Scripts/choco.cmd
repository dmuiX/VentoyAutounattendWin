echo %path%|find /i "choco" > NUL

if %errorlevel% == 0 (
set log=%systemdrive%\%~n0.log
choco feature enable -n allowEmptyChecksums
choco feature enable -n allowGlobalConfirmation
choco install sudo -y -r %log%
choco install clink-maintained -y -r %log%
choco install steam -y -r %log%
choco install choco-cleaner -y -r %log%
choco install firefox -y -r %log%
choco install microsoft-windows-terminal -y -r %log%
choco install hashtab -y -r %log%
choco install 7zip -y -r %log%
choco install auto-dark-mode -y -r %log%
choco install itunes -y -r %log%
choco install mediainfo -y -r %log%
choco install advanced-renamer -y -r %log%
choco install vscode -y -r %log%
choco install treesizefree -y -r %log%
choco install defraggler -y -r %log%
choco install vmwareworkstation -y -r %log%
choco install mpc-be -y -r %log%
choco install logitech-unifying -y -r %log%
choco install logitech-options -y -r %log%
choco install teracopy -y -r %log%
choco install partitionwizard -y -r %log%
choco install git -y -r %log%
choco install choco-cleaner -y -r %log%
)