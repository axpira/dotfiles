#!/bin/bash

layout=$1


logger "set keyboard layout $layout"
if [ "$layout" != "status" ]; then
  if [ "$layout" == "intl" ]; then
    setxkbmap -layout us -variant intl -option lv3:ralt_switch
    echo -e "KEYBOARDus_intl" >> /tmp/panel-fifo
  elif [ ! -z "$layout" ]; then
    setxkbmap -layout $layout
    echo -e "KEYBOARD$layout" >> /tmp/panel-fifo
  fi
  xmodmap -e "clear Lock"
  xmodmap -e "keycode 66 = Escape NoSymbol Escape"        #this will make Caps Lock to act as Esc
fi


config=$(setxkbmap -query | grep -E "(layout|variant)" | cut -d":" -f2 | tr -d " " | tr "\n" "_")
if [[ -p "/tmp/panel-fifo" ]]; then
  echo -e "KEYBOARD${config::-1}" >> /tmp/panel-fifo
fi


