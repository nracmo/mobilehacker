#!/bin/bash

sudo systemctl enable ssh
sudo systemctl start ssh
sudo timedatectl set-ntp true
sudo echo “FallbackNTP=time.nist.gov” /etc/systemd/timesyncd.conf
sudo systemctl restart systemd-timesyncd
