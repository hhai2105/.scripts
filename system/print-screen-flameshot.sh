
#!/usr/bin/env zsh
set -euo pipefail

function crop () {
    scrot -s -f ${NAME};
    xclip -selection clipboard -t image/png ${NAME};
}

function window () {
    scrot -u -f ${NAME};
    xclip -selection clipboard -t image/png ${NAME};
}

function all () {
        scrot -f ${NAME};
        xclip -selection clipboard -t image/png ${NAME};
}

function monitor () {
    flameshot screen
    xclip -selection clipboard -t image/png ${NAME};
}

NAME=~/Pictures/Screenshots/$(date '+%m-%d-%Y_%H-%M-%S').png;
case "$1" in
    -c)
	crop
	;;
    -w)
	window
	;;
    -a)
        all
        ;;
    -m)
        monitor
        ;;
esac
