#!/usr/bin/env zsh
set -euo pipefail

DEVICE="wlp4s0"
label_disconnected="󰤮"
ramp_signal_0="󰤯"
ramp_signal_1="󰤟"
ramp_signal_2="󰤢"
ramp_signal_3="󰤥"
ramp_signal_4="󰤨"

if nmcli device show $DEVICE | grep "GENERAL.STATE" | grep "connected">/dev/null; then
	SIGNAL=$(nmcli -f IN-USE,SIGNAL dev wifi list | grep -Po "\* *\K[0-9]*")
	NAME=$(nmcli -f IN-USE,SSID dev wifi list | grep -Po "\* *\K.*" | sed "s/ *$//g")
    SIGNALSTRENGTH=$((SIGNAL / 20));
	OUTPUT=""
	if [ $SIGNALSTRENGTH -eq 0 ]; then
		OUTPUT+="$ramp_signal_0 "
	elif [ $SIGNALSTRENGTH -eq 1 ]; then
		OUTPUT+="$ramp_signal_1 "
	elif [ $SIGNALSTRENGTH -eq 2 ]; then
		OUTPUT+="$ramp_signal_2 "
	elif [ $SIGNALSTRENGTH -eq 3 ]; then
		OUTPUT+="$ramp_signal_3 "
	elif [ $SIGNALSTRENGTH -eq 4 ]; then
		OUTPUT+="$ramp_signal_4 "
	fi
	OUTPUT+="$NAME"
	echo $OUTPUT
else
	echo $label_disconnected
fi
