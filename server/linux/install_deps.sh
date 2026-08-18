#!/bin/bash

sudo apt-get update
sudo apt-get install gpsd gpsd-clients pps-tools

cp gpsb /etc/default/gpsd

sudo systemctl restart gpsd
sudo systemctl restart chrony

# Check if Chrony sees the GPS refclock
chronyc sources -v
