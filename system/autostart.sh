#!/usr/bin/zsh

function run {

    if ! pgrep $1 ;
  then
    $@&
  fi
}

#Set your native resolution IF it does not exist in xrandr
#More info in the script
#run $HOME/.xmonad/scripts/set-screen-resolution-in-virtualbox.sh

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
brightnessctl --device='asus::kbd_backlight' set 0;
autorandr -c;
run picom;
run $HOME/.config/polybar/launch.sh;
/usr/lib/xfce4/notifyd/xfce4-notifyd &

#change your keyboard if you need it
#setxkbmap -layout be

#cursor active at boot
xsetroot -cursor_name left_ptr &
run nitrogen --restore &
run optimus-manager-qt &
# run audio-fix &
run xfce4-power-manager &
run ibus-daemon -d &
run emacs --daemon &
run numlockx on &
run syncthing -no-browser&
run mpDris2 & 
