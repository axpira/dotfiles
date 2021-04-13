#!/bin/sh

id=$(xinput list --id-only "SynPS/2 Synaptics TouchPad")

if xinput list-props $id | grep "Device Enabled (.*):.*1" >/dev/null
then
  xinput disable $id
  #dunstify -u low -i mouse "Trackpad disabled"
else
  xinput enable $id
  #dunstify -u low -i mouse "Trackpad enabled"
fi
