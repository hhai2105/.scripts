#!/usr/bin/env zsh
set -euo pipefail

BAT="BAT1"
CHARGER="ACAD"
ramp_capacity_0=""
ramp_capacity_1=""
ramp_capacity_2=""
ramp_capacity_3=""
ramp_capacity_4=""
charging=""

CHARGE=$(cat /sys/class/power_supply/$BAT/capacity)
CHARGEDIVIDE=$((CHARGE / 20))
OUTPUT=""
if [ $(cat /sys/class/power_supply/ACAD/online) = 1 ]; then
	OUTPUT+="$charging "
fi
if [ $CHARGEDIVIDE -eq 0 ]; then
	OUTPUT+="$ramp_capacity_0 "
elif [ $CHARGEDIVIDE -eq 1 ]; then
	OUTPUT+="$ramp_capacity_1 "
elif [ $CHARGEDIVIDE -eq 2 ]; then
	OUTPUT+="$ramp_capacity_2 "
elif [ $CHARGEDIVIDE -eq 3 ]; then
	OUTPUT+="$ramp_capacity_3 "
elif [ $CHARGEDIVIDE -ge 4 ]; then
	OUTPUT+="$ramp_capacity_4 "
fi
OUTPUT+=$CHARGE
OUTPUT+="%"
echo $OUTPUT
