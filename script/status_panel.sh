#!/bin/bash

max_width=$(xdpyinfo | sed -nE "s/^ *dimensions:[[:space:]]*([0-9]+)x([0-9]*).*$/\1/p")
panel_width=$((max_width / 4 * 2))
margin=50
panel_right_margin=$((- (panel_width + margin)))

finish() {
    pkill status.sh
    rm $PANEL_FIFO
    bspc config top_padding 0
    # bspc wm -r
    trap - TERM
    kill 0
}
trap 'finish' INT TERM QUIT EXIT

[ -e $PANEL_FIFO ] && rm $PANEL_FIFO
mkfifo $PANEL_FIFO


while true; do status.sh time; sleep 59; done &
while true; do status.sh bluetooth wifi battery; sleep 10; done &

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
    printf "$wm^fg()^bg()\n"
}

# bspc subscribe report | while read -r line; do
while read -r line; do
    wm=$(parse_loop $line)
    name="$(/usr/bin/xdotool getactivewindow getwindowname)"
    printf "%s %s\n" "$wm" "$name"
done < <(bspc subscribe report) | dzen2 -fn 'FiraCode Nerd Font:size=10' -ta l -fg '#717171' -w $panel_width -dock &


while true; do
    while read -r line < $PANEL_FIFO ; do
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
    done | dzen2 -fn 'FiraCode Nerd Font:size=10' -dock -w $panel_width -x $panel_right_margin -ta r -fg '#717171'
done &
status.sh &

wait
