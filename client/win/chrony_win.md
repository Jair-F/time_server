


test:
While your 15-minute sync script is active, you can monitor the real-time jitter filters by opening another terminal window on the client and typing:

chronyd -Q 'server 127.0.0.1 maxsamples 1'
"C:\Program Files (x86)\NTP\bin\ntpdate.exe" -q 192.168.1.100


