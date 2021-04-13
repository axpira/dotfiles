

#pkill dunst
#nohup dunst &
#pkill stalonetray
#nohup stalonetray -i 22 --geometry 10x1+350+0 -bg "#333232" &

#xset +fp ~/.local/share/fonts
#xset fp+ ~/.fonts
#xset +fp /home/axpira/.local/share/fonts
#xset fp+ /usr/share/fonts/TTF
#xset fp rehash


#(
##/usr/bin/setxkbmap -option "caps:swapescape"
#/usr/bin/xmodmap -e 'keycode 77 = NoSymbol Num_Lock'
##/usr/bin/setxkbmap -layout us -variant altgr-intl -option "caps:escape"
#/usr/bin/xinput disable 'AT Translated Set 2 keyboard'
#/usr/bin/numlockx on
#) &


xrdb -merge ~/.config/Xresources
#libinput-gestures-setup start &

#$HOME/scripts/keyboard.sh us &

#xrandr --setprovideroffloadsink 1 0
#xrandr --setprovideroutputsource 1 0

#exec bspwm
#exec wmwm -launcher dmenu_run -term alacritty
#exec leftwm
#exec dwm
exec awesome
#exec herbstluftwm
