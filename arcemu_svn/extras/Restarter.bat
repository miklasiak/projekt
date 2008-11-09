@ECHO off
color 2
:start
CLS
ECHO   ###################################
ECHO   #   Willkommen zum Arcemu Tool    #
ECHO   #  Copyright by Evolution-Cores   #
ECHO   #  http://evolution-cores.ath.cx  #
ECHO   #                                 #
ECHO   ###################################
PAUSE
:menu
CLS
ECHO           Bitte Wählen:
ECHO.      
ECHO Arcemu World starten          - 1
ECHO Arcemu Logonserver Starten    - 2
ECHO Server Restarten              - 3
ECHO Arcemu Tool schliessen        - X
ECHO.
set /p l=         Zahl eingeben:         
if %l%==1 goto world
if %l%==2 goto logon
if %l%==3 goto restart
if %l%==4 goto worldkill
if %l%==5 goto logonkill
if %l%==X goto ende
if %l%==x goto ende
if %l%==* goto error
:world
CLS 
start cmd /c arcemu-world.exe
ECHO Arcemu-World erfolgreich gestartet!
ECHO.
set /p b=   Arcemu-Logonserver starten Ja/Nein:
if %b%==Ja goto logon
if %b%==Nein goto menu
if %b%==* goto menu
:logon
CLS
start cmd /c arcemu-logonserver.exe
ECHO Arcemu-Logonserver erfolgreich gestartet
Pause
GOTO Menu
:restart
CLS
set /p a=  Server restarten? Ja/Nein:
if %a%==Ja goto 1
if %a%==Nein goto menu
if %a%==* goto menu
:1
taskkill /f /im arcemu-logonserver.exe
taskkill /f /im arcemu-world.exe

start cmd /c arcemu-logonserver.exe
start cmd /c arcemu-world.exe
ECHO Server Erfolgreich restartet
Pause
GOTO menu
:worldkill
CLS
taskkill arcemu-world.exe
ECHO Arcemu-World erfolgreich beendet
Pause
GOTO menu
:logonkill
CLS
taskkill arcemu-logonserver.exe
ECHO Arcemu_Logonserver erfolgreich beendet
Pause
GOTO menu
:error
Ein Fehler ist aufgetreten, sie werden zum Menu weitergeleitet
GOTO menu
:ende
