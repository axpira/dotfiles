#!/bin/bash
set -x

logger "StatusBar $1"
case "$1" in
    start) 
        #~/.config/script/panel/panel &
		bspc config top_padding 10
		polybar top &
        ;;
    stop)
        #killall panel
        #rm -rf /tmp/panel-fifo
		pkill polybar
		bspc config top_padding 0
        ;;
    toggle)
        #killall panel
        #if [[ $? == 0 ]]; then
        #  #bspc config top_padding 0
        #  rm -rf /tmp/panel-fifo
        #else
        #  #bspc config top_padding 10
        #  ~/.config/script/panel/panel &
        #fi
		pkill polybar
        if [[ $? == 0 ]]; then
		  
          bspc config top_padding 0
		else
          bspc config top_padding 10
          #~/.config/script/panel/panel &
		  polybar top &
        fi
        ;;
esac

