#!/bin/sh
 
bat=$(battery)
temp=" "
for path in /sys/class/thermal/thermal_zone*; do
	t=$(cat $path/temp)
	temp="$temp$((t / 1000))糖 "
done
vol=$(volume)
bright=$(backlight)
date=$(date +'%A, %B %d %Y %H:%M:%S')
xsetroot -name "$temp $vol $bright $bat $date"
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
