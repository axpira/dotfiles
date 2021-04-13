#!/bin/bash

logger "conky.sh"
#if [[ ! -z $(xdotool search --classname 'Conky') ]]; then
 
killall conky

if [[ $? == 0 ]]; then
  bspc config right_padding 0
else
  bspc config right_padding 450
  conky
fi
