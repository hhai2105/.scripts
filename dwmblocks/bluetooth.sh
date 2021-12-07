#!/usr/bin/env zsh
set -euo pipefail

POWER=$(bluetoothctl show | grep -Po "Powered: \K[a-z]*")

OUTPUT=""
if [ "$POWER" = "yes" ]; then
	if bluetoothctl devices | cut -f2 -d" " | while read uuid; do bluetoothctl show $uuid ; done | grep connected; then
		OUTPUT=""
	elif bluetoothctl show | grep "Discovering: yes" > /dev/null; then
		OUTPUT=""
	else
		OUTPUT=""
	fi
else
	OUTPUT=""
fi

echo $OUTPUT


