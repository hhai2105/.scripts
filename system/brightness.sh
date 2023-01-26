#!/usr/bin/env bash

STEP=2

function brightnessUp {
	lux -a ${STEP}%
	VAL=$(lux -G | grep -Po "[0-9]*")
	dunstify -a "brightness" "brightness" "${VAL}%" -r 991852 -h int:value:$VAL -t 1000
}

function brightnessDown {
	lux -s ${STEP}%
	VAL=$(lux -G | grep -Po "[0-9]*")
	dunstify -a "brightness" "brightness" "${VAL}%" -r 991852 -h int:value:$VAL -t 1000
}
case "$1" in
    --up)
        brightnessUp
		;;
    --down)
        brightnessDown
        ;;
esac
