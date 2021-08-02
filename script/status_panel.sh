#!/bin/bash

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

while true; do status.sh time; sleep 59; done &
while true; do status.sh battery bluetooth wifi; sleep 10; done &

# parse_sed() {
#     sed -E \
#         -e 's/^WM(.[^:]*)//' \
#         -e 's/^(.*):L([TM][^:]*)(.*)$/^fg()^bg()\2^p(5)\1\3/' \
#         -e 's/^(.*):T([TPF=@][^:]*)(.*)$/^fg()^bg()\2^p(5)\1\3/' \
#         -e 's/^(.*):G([SPLM][^:]*)?(.*)$/^fg()^bg()\2^p(5)\1\2/' \
#         -e 's/:f([0-9][^:]*)//g' \
#         -e 's/(:O|:F)(.[^:]*)/^fg()^bg(#285577)^r(15)\2^r(15)/g' \
#         -e 's/:o(.[^:]*)/^fg()^bg()^r(5)\1^r(5)/g' \
#         -e 's/$/^fg()^bg()/' <<< $1
# }

parse_loop() {
    local line=$1
    # bspwm's state
    local wm=""
    IFS=':'
    set -- ${line#?}
    while [ $# -gt 0 ] ; do
        local item=$1
        local name=${item#?}
        case $item in
            o*)
                # occupied desktop
                wm="${wm}^bg()^r(5)$name^r(5)"
                ;;
            [FO]*)
                # focused occupied desktop
                wm="${wm}^bg(#3B4252)^r(15)$name^r(15)"
                ;;
            [Uu]*)
                # urgent desktop
                wm="${wm}^bg(#BF616A)^r(5)$name^r(5)"
                ;;
            [LTG]*)
                # layout, state and flags
                wm="$name$wm"
                ;;
        esac
        shift
    done
    printf "$wm^fg()^bg()"
}

# bspc subscribe report | while read -r line; do
while read -r line; do
    wm=$(parse_loop $line)
    name=$(xdotool getactivewindow getwindowname)
    printf "%s %s\n" "$wm" "$name"
done < <(bspc subscribe report) | dzen2 -fn 'FiraCode Nerd Font:size=12' -ta l -fg '#717171' -w 1600 -dock &

# bspc subscribe report | while read -r line; do
#     xdotool getactivewindow getwindowname
# done | dzen2 -fn 'FiraCode Nerd Font:size=12' -ta c -w 800 -fg '#717171' -bg '#0000ff' &
# mkfifo /tmp/left-bar
# mkfifo /tmp/middle-bar
# mkfifo /tmp/right-bar

status.sh &

while read -r line < /tmp/panel-fifo ; do
    case $line in
        TIME*)
            time="${line:4}"
            ;;
        BATTERY*)
            battery="${line:7}"
            ;;
        BACKLIGHT*)
            backlight="${line:9}"
            ;;
        VOLUME*)
            volume="${line:6}"
            ;;
        BLUETOOTH*)
            bluetooth="${line:9}"
            ;;
        WIFI*)
            wifi="${line:4}"
            ;;
    esac
    msg="^fg(#81A1C1)${bluetooth} ^fg(#98971a)${wifi} ^fg(#689d6a)${volume} ^fg(#d79921)${backlight} ^fg(#98971a)${battery} ^fg()${time}"
    printf "%s\n" "$msg"
done | dzen2 -fn 'FiraCode Nerd Font:size=12' -dock -w 2000 -x -2100 -ta r -fg '#717171' &


wait
