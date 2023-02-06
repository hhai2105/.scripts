#!/bin/bash
set -euo pipefail

#--------variables--------
format="%artist% - %title%"
songName_foreground="#42c6ff"
songName_paused_foreground="#ff2afc"
bar_progress_width=15
bar_progress_fill="—"
bar_progress_fill_foreground="#42c6ff"
bar_progress_indicator="—"
# bar_progress_indicator_foreground="#ff2afc"
bar_progress_indicator_foreground="#42c6ff"
bar_progress_empty="—"
bar_progress_empty_foreground="#A875FF"

bar_volume_width=15
bar_volume_fill="—"
bar_volume_fill_foreground="#42c6ff"
bar_volume_indicator="—"
bar_volume_indicator_foreground="#42c6ff"
bar_volume_empty="—"
bar_volume_empty_foreground="#A875FF"

volume_step=2

listenSong(){
    # songName="%{F$songName_foreground}$(mpc -f "${format}" current)"
	: | zscroll  --delay 1 --match-command "mpc status" \
				 --match-text "playing" "--before-text '%{F$songName_foreground}' --after-text '%{F-}'" \
				 --match-text "paused" "--before-text '%{F$songName_paused_foreground}' --after-text '%{F-}' --scroll 0" \
				 --update-check true "mpc  -f '${format}' current"
}

getVolume(){
    VOLUME="$(mpc volume | grep -Po 'volume: *\K[0-9]*')";
}

getElapsed(){
    ELAPSED="$( mpc | head -2 | grep -Po "[0-9]*%" | grep -Po "[0-9]*")"
}

getBarElapsed(){
    getElapsed;
    numElapsed=$((bar_progress_width * ELAPSED / 100));
    barElapsed="%{F${bar_progress_fill_foreground}}"
    i="1"
    while [ $i -lt $numElapsed ]
    do
		barElapsed+="${bar_progress_fill}";
		i=$[$i + 1]
    done
    barElapsed+="%{F-}"
    barElapsed+="%{F${bar_progress_indicator_foreground}}"
    barElapsed+="$bar_progress_indicator"
    barElapsed+="%{F-}"
    barElapsed+="%{F${bar_progress_empty_foreground}}"
    i="1"
    while [ $i -le $((bar_progress_width - numElapsed)) ]
    do
		barElapsed+="${bar_progress_empty}";
		i=$[$i + 1]
    done
    barElapsed+="%{F-}"
	echo ${barElapsed}
}

getBarVolume(){
    getVolume;
    numVolume=$((bar_volume_width * VOLUME / 100));
    barVolume="%{F${bar_volume_fill_foreground}}"
    i="1"
    while [ $i -lt $numVolume ]
    do
		barVolume+="${bar_volume_fill}";
		i=$[$i + 1]
    done
    barVolume+="%{F-}"
    barVolume+="%{F${bar_volume_indicator_foreground}}"
    barVolume+="${bar_volume_indicator}"
    barVolume+="%{F-}"
    barVolume+="%{F${bar_progress_empty_foreground}}"
    i="1"
    while [ $i -le $((bar_volume_width - numVolume)) ]
    do
		barVolume+="${bar_volume_empty}";
		i=$[ $i + 1 ]
    done
    barVolume+="%{F-}"
	echo ${barVolume}
}

listenBarVolume(){
	while true
	do
		if [ "$(mpc | wc -l)" = 1 ];
		then
			echo ""
		else
			getBarVolume
		fi
		mpc idle 1&>/dev/null
	done
}

listenBarElapsed(){
	while true
	do
		if [ "$(mpc | wc -l)" = 1 ];
		then
			echo ""
			mpc idle 1&>/dev/null
		else
			getBarElapsed
			sleep 3
			if mpc status | grep paused	1&>/dev/null;
			then
				mpc idle 1&>/dev/null
			fi
		fi
	done
}



volumeUp(){
    getVolume;
    echo 
    if [ "$((VOLUME + volume_step))" -ge "100" ];
    then
		mpc volume 100;
    else
		mpc volume $((VOLUME + volume_step));
    fi
}


volumeDown(){
    getVolume;
    if [ "$((VOLUME - volume_step))" -le "0" ];
    then
		mpc volume 0;
    else
		mpc volume $((VOLUME - volume_step));
    fi
}

print(){
    if [ "$(mpc | wc -l)" = 1 ];
    then
		echo ""
    else
		getSong;
		getBarVolume;
		getBarElapsed;
		echo "${barVolume}   ${songName}   ${barElapsed}"
    fi
}




case $1 in
    -v)
		listenBarVolume;
		;;
    -c)
		listenSong;
		;;
    -e)
		listenBarElapsed;
		;;
    volUp)
		volumeUp;
		;;
    volDown)
		volumeDown;
		;;
    toggle)
		mpc toggle;
		;;
    next)
		mpc next;
		;;
    prev)
		mpc prev;
		;;
esac
