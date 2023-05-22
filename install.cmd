@echo off
if not exist "%SystemRoot%\System32\tcpsvcs.exe" goto noserver 
echo Choose a number:
echo 1.Use only Nikola Tesla Quotes
echo 2.Add Nikola Telsa Quotes to the end of config file and keep default quotes
echo 3.Uninstall
echo 4.Abort
choice /C 1234 /M "Pick a number"
if errorlevel 4 goto abort
if errorlevel 3 goto undo
if errorlevel 2 goto append
if errorlevel 1 goto overwrite
echo Uh-oh an error %errorlevel%
echo Cannot continue
pause
goto abort
:undo
if not exist "%SystemRoot%\system32\drivers\etc\quotes.rem" goto undoerror1
net stop simptcp
type %SystemRoot%\system32\drivers\etc\quotes.rem>%SystemRoot%\system32\drivers\etc\quotes
net start simptcp
pause
goto abort
:undoerror1
echo The backup file %SystemRoot%\system32\drivers\etc\quotes.rem is missing
pause
goto abort
:append
copy %SystemRoot%\system32\drivers\etc\quotes %SystemRoot%\system32\drivers\etc\quotes.rem
if not exist "%SystemRoot%\system32\drivers\etc\quotes.rem" goto pauseerror
net stop simptcp
type qoutes.txt >> %SystemRoot%\system32\drivers\etc\quotes
net start simptcp
goto abort
:pauseerror
pause
goto abort
:overwrite
copy %SystemRoot%\system32\drivers\etc\quotes %SystemRoot%\system32\drivers\etc\quotes.rem
if not exist "%SystemRoot%\system32\drivers\etc\quotes.rem" goto pauseerror
net stop simptcp
type qoutes.txt >> %SystemRoot%\system32\drivers\etc\quotes
net start simptcp
goto abort
:noserver
echo Simple TCP/IP Servers must be installed.
pause
:abort
