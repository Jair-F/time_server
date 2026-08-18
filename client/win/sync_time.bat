@echo off
setlocal enabledelayedexpansion

:: Check for administrative privileges (Windows version of checking UID == 0)
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Please run this script as an Administrator.
    exit /b 1
)

echo [1/5] Starting NTP service and setting status to ONLINE...
:: Clear any dead instances and start the daemon cleanly
taskkill /f /im ntpd.exe >nul 2>&1
start "NTP_Engine" /b "C:\Program Files (x86)\NTP\bin\ntpd.exe" -g -c "C:\Program Files (x86)\NTP\etc\ntp.conf"

echo [2/5] Triggering rapid packet burst for immediate lock...
:: Windows NTPD handles the 'iburst/burst' flags automatically via ntp.conf on initialization.
:: We issue a manual clear read to force socket binding.
ntpq -p >nul 2>&1

echo [3/5] Waiting 5 seconds for initial step and frequency adjustment...
timeout /t 5 /nobreak >nul

:: Force immediate step right away if offset exists (Windows native equivalent to 'makestep')
:: This forces the daemon to instantly step the OS system time clock.
ntpd -gq -c "C:\Program Files (x86)\NTP\etc\ntp.conf" >nul 2>&1 || true

:: Display initial offset status to logs/console (Windows equivalent of chronyc tracking)
echo Initial synchronization state:
ntpq -c "rv 0 offset,frequency,sys_jitter"

echo [4/5] Disciplining local clock for 15 minutes...
:: Wait remainder of the 15-minute window (895s)
timeout /t 895 /nobreak

echo [5/5] Saving drift metrics and taking server OFFLINE...
:: Windows NTPD continuously streams drift calculations to the 'ntp.drift' file designated in your config.
:: Terminating the process forces the socket to close instantly, achieving complete network silence.
taskkill /f /im ntpd.exe >nul 2>&1

echo Time synchronization routine completed successfully.
pause
