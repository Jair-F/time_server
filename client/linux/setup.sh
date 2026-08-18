#!/bin/bash

sudo apt install -y chrony vim
# copy the chrony file to the right place
cp ./chrony.conf /etc/chrony/chrony.conf

# chronyd -Q 'server 127.0.0.1 maxsamples 1'
# sudo systemctl restart chronyd

# docker build -t tmp .
# docker run -it --rm --privileged --cap-add=SYS_TIME tmp bash
