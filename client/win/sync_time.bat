@echo off

:: Stop the active Windows Time service
net stop w32time
:: Permanently disable it from starting automatically
:: sc config w32time start= disabled
:: Strip the w32time service definition completely out of the system registry
:: w32tm /unregister

echo Starting maximum precision NTP synchronization cycle...

:: 1. Force a strict synchronized termination run (-g allows large initial time jumps)
"C:\Program Files (x86)\NTP\bin\ntpd.exe" -g -q -c "C:\Program Files (x86)\NTP\etc\ntp.conf"

echo Synchronization complete. Network sockets closed. All packet traffic stopped.
pause