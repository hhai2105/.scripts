#!/usr/bin/zsh

function run {
    if ! pgrep $1 ;
  then
    $@&
  fi
}

/usr/bin/prime-offload

#cursor active at boot
run powerkit &
run imwheel &
run ./key_repeat.sh &
run syncthing --no-browser &
run optimus-manager-qt &
run ibus-daemon -d &
run emacs --daemon &
run mpDris2 &
run mpd &
run blueman-tray &
run udiskie &
run $HOME/.scripts/system/l5p_kbl.py static 111111 111111 111111 111111 --brightness 1 &
run blueberry-tray &
run openrazer-daemon &
run dunst &
run mpv --input-ipc-server=/tmp/mpvsocket &
run waybar &
# run mailspring -b &
# run $HOME/.scripts/system/dynamic-wallpaper.sh &
