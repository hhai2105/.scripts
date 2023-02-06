#!/bin/bash
interval=5
maxVolBeforeAdj=$((100 - interval))
minVolBeforeAdj=$((0 + interval))
VolUp(){
    curvol=$(deadbeef --volume | grep -Po ".{0,3}%" | sed "s/%//g")
    if [ $curvol -gt $maxVolBeforeAdj ]
    then
	deadbeef --volume 100
	exit;
    fi
    deadbeef --volume $(( curvol + interval ))
}

VolDown(){
    curvol=$(deadbeef --volume | grep -Po ".{0,3}%" | sed "s/%//g")
    if [ $curvol -lt $minVolBeforeAdj ]
    then
	deadbeef --volume 0
	exit;
    fi
    deadbeef --volume $(( curvol - interval ))
}

play-pause(){
    deadbeef --play-pause
}

main() {
    OUTPUT=$(deadbeef --nowplaying-tf "%artist% - %title% \[ %playback_time% - %length% \]")
    echo "${OUTPUT}"
}
if ! pgrep -x deadbeef-main >/dev/null;
then
    echo "";
    exit;
fi
case "$1" in
    --up)
	VolUp
	;;
    --down)
	VolDown
	;;
    --toggle)
	play-pause
	;;
    *)
	main "$@";
	;;
esac

