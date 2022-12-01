#!/usr/bin/env zsh

ID=$(xinput | grep -P "ITE.*Keyboard.*\[slave *keyboard" | grep -Po "id=\K[0-9]*")
STATUS=$(xinput --list-props $ID | grep -Po "Device Enabled.*:[ \t]*\K[0-9]*")
echo $STATUS
if [ $STATUS = "0" ];
then
   xinput enable $ID
else
	xinput disable $ID
fi
