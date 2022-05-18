#!/usr/bin/zsh

function run {
    if ! pgrep $1 ;
  then
    $@&
  fi
}

autorandr -c
#Set your native resolution IF it does not exist in xrandr
#More info in the script
#run $HOME/.xmonad/scripts/set-screen-resolution-in-virtualbox.sh

/usr/bin/prime-offload
optimus-manager-qt &

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output edp-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
#run $HOME/.config/polybar/launch.sh;

#change your keyboard if you need it
#setxkbmap -layout be

#cursor active at boot
#run picom &
run syncthing --no-browser &
run xsetroot -cursor_name left_ptr &
run optimus-manager-qt &
run xfce4-power-manager &
run ibus-daemon -d &
run emacs --daemon &
run numlockx on &
run mpDris2 &
run mpd &
run blueman-applet &
run /usr/lib/xfce4/notifyd/xfce4-notifyd &
run brightnessctl --device='asus::kbd_backlight' set 0 &
