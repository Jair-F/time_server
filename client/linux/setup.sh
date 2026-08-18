#!/bin/bash

# sudo apt install chrony
# copy the chrony file to the right place
cp ./chrony.conf /etc/chrony/chrony.conf

# chronyd -Q 'server 127.0.0.1 maxsamples 1'
sudo systemctl restart chronyd


