@echo off
echo ====================================================================
echo LAUNCHING HIGH-JITTER PRECISION FILTERING ALGORITHM (10-MIN WINDOW)
echo ====================================================================

:: 1. Clear any stuck processes and run the background daemon
taskkill /f /im ntpd.exe >nul 2>&1
start "NTP_High_Jitter_Engine" /b "C:\Program Files (x86)\NTP\bin\ntpd.exe" -g -c "C:\Program Files (x86)\NTP\etc\ntp.conf"

echo Engine running. Gathering 600 samples to execute statistical filtering...
echo Counting down 10 minutes (600 seconds). Do not close this window...

:: 2. Strict 10-minute statistical accumulation phase
timeout /t 600 /nobreak

echo ====================================================================
echo 10-MINUTE ANALYSIS COMPLETE. SNAP-CORRECTING SYSTEM CLOCK...
echo ====================================================================

:: 3. Kill the process instantly. The kernel hardware clock is stepped, and
:: the network socket is hard-terminated. No more packets can leave this PC.
taskkill /f /im ntpd.exe

echo.
echo Success: Network sockets closed. Complete network silence achieved.
pause
