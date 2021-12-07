#!/usr/bin/env zsh
set -euo pipefail

DEVICE="wlp4s0"
label_disconnected="󰤮"
ramp_signal_0="󰤯"
ramp_signal_1="󰤟"
ramp_signal_2="󰤢"
ramp_signal_3="󰤥"
ramp_signal_4="󰤨"

if grep $DEVICE /proc/net/wireless>/dev/null; then
	NAME=$(iwgetid -r)
	SIGNAL=$(grep wlp4s0 /proc/net/wireless | awk '{print $3}' | grep -Po "[0-9]*")
	SIGNALSTRENGTH=$((SIGNAL * 100 / 70))
	OUTPUT=""
	if [ $SIGNALSTRENGTH -eq 0 ]; then
		OUTPUT+="$ramp_signal_0 "
	elif [ $SIGNALSTRENGTH -eq 1 ]; then
		OUTPUT+="$ramp_signal_1 "
	elif [ $SIGNALSTRENGTH -eq 2 ]; then
		OUTPUT+="$ramp_signal_2 "
	elif [ $SIGNALSTRENGTH -eq 3 ]; then
		OUTPUT+="$ramp_signal_3 "
	elif [ $SIGNALSTRENGTH -ge 4 ]; then
		OUTPUT+="$ramp_signal_4 "
	fi
	OUTPUT+="$NAME"
	echo $OUTPUT
else
	echo $label_disconnected
fi

