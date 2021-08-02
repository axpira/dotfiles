#!/bin/sh

# valor icon porcentagem

# bateria
#   100% 04:00
#   -50% 02:00
#   +30% 00:30
#   !50%

# volume
#   100%
#   50%
#   -10%
#   +10%

# backlight
#   10%
#   0%
#   50%

# temp
#   50 61 44 50

# notify battery time ....
#trap 'trap - TERM; kill 0' INT TERM QUIT EXIT
PANEL_FIFO=/tmp/panel-fifo

# [ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
# mkfifo "$PANEL_FIFO"

function get_icon {
    local icons=$1
    local percent=$2
    local size=${#icons}
    local index=$((percent/(size-1)))
    ((index >= size)) && index=$((size-1))
    echo ${icons:$index:1}
}

separator=""
function get_battery_status {
    local fields=($(battery))
    case "${fields[0]}" in
        "-")
            local icon=$(get_icon "" "${fields[1]}")
            printf "%s%s%s%%%s%s" "$icon" "$separator" "${fields[1]}" "$separator" "${fields[2]}"
            ;;
        "+") printf "" ;;
        '#') printf "" ;;
        *) printf "" ;;
    esac
}

function get_backlight {
    local percent="$(backlight)"
    local icon=$(get_icon "" "$percent")
    printf "%s %s" "$icon $percent"
}

function get_time {
    date +'%A, %B %d %Y %H:%M'
}

function get_volume {
    local fields=($(volume))
    local icon=""
    if [[ "$fields[0]}" == "-" ]]; then
        icon="婢"
    else
        icon="墳"
    fi
    printf '%s %s%%' "$icon" "${fields[1]}"
}

function get_bluetooth {
    local fields=($(bluetooth))
    local icon=""
    case "${fields[0]}" in
        "-") printf '\n' ;;
        "+") printf '\n' ;;
        "=") printf ' %s\n' "${fields[1]}" ;;
        *) printf ' ERROR\n' ;;
    esac
}

function get_wifi {
    printf " $(wifi)\n"
}

function update {
    local key=""
    local value=""
    case $1 in
        battery) key=BATTERY; value="$(get_battery_status)" ;;
        time) key=TIME; value="$(get_time)" ;;
        bluetooth) key=BLUETOOTH; value="$(get_bluetooth)" ;;
        backlight) key=BACKLIGHT; value="$(get_backlight)" ;;
        volume) key=VOLUME; value="$(get_volume)" ;;
        wifi) key=WIFI; value="$(get_wifi)" ;;
        wm) key=WM; value="$(get_wm)" ;;
    esac
    [[ -n $key ]] && printf "%s%s\n" "$key" "$value" > $PANEL_FIFO
}

actions=$@
if [[ -z $actions ]]; then
    for action in battery time volume backlight volume bluetooth; do
        update $action
    done
else
    for action in $actions; do
        update $action
    done
fi



# exit 0
# bat=$(battery_status)
# # bat=$(battery)
# temp=" "
# for path in /sys/class/thermal/thermal_zone*; do
# 	t=$(cat $path/temp)
# 	temp="$temp$((t / 1000))糖 "
# done
# vol=$(volume)
# bright=$(backlight)
# date=$(date +'%A, %B %d %Y %H:%M:%S')
#xsetroot -name "$temp $vol $bright $bat $date"
# printf "%s %s %s %s %s" "$temp" "$vol" "$bright" "$bat" "$date"

# printf "RAW%s %s %s %s" "$temp" "$vol" "$bright" "$bat" |
# 	lemonbar -f "FiraCode Nerd Font:size=14:pixelsixe=20:antialias=true:autohint=true:style=Retina,Regular" -p
#wm=$(get_wm)
#printf "%s\n" "%{l}${wm}%{c}title%{r}$bat $vol $bright"
#printf "%s\n" "%{l}${wm}%{c}title%{r}$bat $vol $bright"
#ps axch -o cmd:20,pid:15,%cpu --sort=-%cpu | head
#echo '---'

#free -m | awk '/^Mem:/ {print $3 "/" $2}'
#free -m
#echo '---'
#sensors | awk '/^temp1/ {print $2}'
#echo '---'
#ps axch -o cmd,%mem --sort=-%mem | sed 11q
#echo '---'
#ps axch -o cmd:15,%cpu --sort=-%cpu | sed 11q
#echo '---'
#printf "^fg(#ff0000)%s ^fg(#00ff00)%s ^fg(#0000ff)%s ^fg()%s %s\n" "$temp" "$vol" "$bright" "$bat" "$date" 
#printf "%s\n" "$bat"
#| dzen2 -p -fn 'FiraCode Nerd Font:size=20'



# status_panel.sh < "$PANEL_FIFO" | dzen2 -fn 'FiraCode Nerd Font:size=20' | sh &

# printf "%s\n" "$bat" > "$PANEL_FIFO"


#wait
# while true; do
#     while read -r line ; do
#         case $line in
#             DATE*)
#                 # clock output
#                 date="${line#????}"
#                 ;;
#             TIME*)
#                 time="${line#????}"
#                 ;;
#             *)
#                 tmp="$line"
#                 ;;
#         esac
#         printf "%s\n" "${date}${time}"
#     done < /tmp/panel-fifo
# done | dzen2 -fn 'FiraCode Nerd Font:size=20'
