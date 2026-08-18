#!/bin/bash
set -e

# Check for root privileges
if [ "$EUID" -ne 0 ]; then 
  echo "Error: Please run as root"
  exit 1
fi

# /etc/init.d/chrony start

SERVER_IP="172.18.0.1"

echo "[1/5] Setting Chrony server status to ONLINE..."
chronyc online #"$SERVER_IP"

echo "[2/5] Triggering rapid 8-packet burst for immediate lock..."
chronyc burst 8/8

echo "[3/5] Waiting 5 seconds for initial step and frequency adjustment..."
sleep 5

# Force immediate step right away if offset exists (just in case)
chronyc makestep > /dev/null 2>&1 || true

# Display initial offset status to logs/console
echo "Initial synchronization state:"
chronyc tracking | grep -E "(RMS offset|System time|Frequency)"

echo "[4/5] Disciplining local clock for 15 minutes..."
# Wait remainder of the 15-minute window (895s)
sleep 895

echo "[5/5] Saving drift metrics and taking server OFFLINE..."
# Force Chrony to write the calculated frequency drift to disk
chronyc dump

# Disconnect server to stop all outbound UDP NTP traffic
chronyc offline #"$SERVER_IP"

echo "Time synchronization routine completed successfully."