#!/bin/bash
# Check for root privileges
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root"
  exit 1
fi

echo "1. Opening firewall and telling Chrony the server is ONLINE..."
chronyc online

echo "2. Forcing an aggressive packet burst to jumpstart jitter analysis..."
chronyc burst 4/16

echo "3. Analyzing network delays for 15 minutes to find maximum precision..."
# Wait 15 minutes (900 seconds)
sleep 900

echo "4. Forcing immediate clock correction based on best statistical samples..."
chronyc makestep

echo "5. Forcing server OFFLINE. Closing sockets. Traffic stopped."
chronyc offline

echo "Time synchronization routine finished successfully."
