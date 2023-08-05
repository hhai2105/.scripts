#!/usr/bin/env zsh

#added udev rule to run mouseless without root
echo "KERNEL==\"uinput\", GROUP=\"$USER\", MODE:=\"0660\"
KERNEL==\"event*\", GROUP=\"$USER\", NAME=\"input/%k\", MODE=\"660\"" \
| sudo tee /etc/udev/rules.d/99-$USER.rules
