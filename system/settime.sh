#!/usr/bin/env zsh

ZONE=$(ls /usr/share/zoneinfo/ | rofi -dmenu -i -p "Choose Zone")
CITY=$(ls /usr/share/zoneinfo/${ZONE} | rofi -dmenu -i -p "Choose City")
sudo rm -rf /etc/localtime
sudo ln -sf /usr/share/zoneinfo/${ZONE}/${CITY} /etc/localtime
sudo hwclock --systohc
