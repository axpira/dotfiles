#!/bin/bash
icon_path="/usr/share/icons/Adwaita/64x64"
logger "notify.sh $*"
notify(){
  #notify-send -a mynotify "$@"
  dunstify -a mynotify "$@"
}


info=$1

#notify-send -a "mynotify" "$(neofetch --stdout)"
case $info in
  all)
    date_str="$(date '+%A, %B %d %Y  %H:%M:%S')"
    battery_str="$(acpi)"
    sound_str="$(amixer get Master | grep Mono: | cut -d" " -f6,8)"
    backlight_str="$(cat /sys/class/backlight/acpi_video0/brightness)"
    wifi_ssid_str=$(/usr/sbin/iw wlp6s0 info | grep ssid | tr -s " " | cut -d" " -f2)
    ip_str=$(ip addr show wlp6s0 | sed '3!d' | tr -s " " | cut -d" " -f3)
    mem_str=$(free -h)
    notify -r 1 "$date_str\n\n$battery_str\n\nVolume: $sound_str\n\nBacklight: $backlight_str\n\nWifi ssid: $wifi_ssid_str\n\nIP: $ip_str\n\n$mem_str"
    ;;

  date)
    date_str="$(date '+%A, %B %d %Y\n%H:%M:%S')"
    notify -i "$icon_path/status/alarm-symbolic.symbolic.png" -r 2 "$date_str"
    ;;
  battery)
    battery_path="/sys/class/power_supply/BAT0"
    message="$(acpi)"
    #notify -i "$icon_path/status/battery-full-symbolic.symbolic.png" -r 2 "$(cat $battery_path/uevent | sed 's/$/\\n/' | tr -d '\n')"
    notify -i "$icon_path/status/battery-full-symbolic.symbolic.png" -r 3 "$message"
    ;;
  *) notify "Error";;
esac


