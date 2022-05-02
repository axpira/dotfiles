#!/bin/bash
set -e

external="HDMI-1"
internal="eDP-1"
#internal_resolution="1366x768"
external_resolution="${MONITOR_EXTERNAL_RESOLUTION:-1920x1080}"
internal_resolution="${MONITOR_INTERNAL_RESOLUTION:-1920x1080}"
position="${MONITOR_INTERNAL_POSITION:-right}" # primary position
dpi=${DPI:-96}
# ##I would like to use Nouveau for offloading the Intel card
# xrandr --setprovideroffloadsink nouveau modesetting
# #If the second GPU has outputs that aren't accessible by the primary GPU, you can use "Reverse PRIME" to make use of them. This will involve using the primary GPU to render the images, and then pass them off to the secondary GPU
# xrandr --setprovideroutputsource nouveau modesetting
# xrandr --output HDMI-1-1 --auto --above eDP-1
output=$(xrandr)
function get_output_name {
  # grep -Po "^$1[0-9-]+(?= )" <<< $output || true
  grep -Po "^$1(?= )" <<< $output || true
}
function is_output_connected {
  grep -q "^$1 connected" <<< $output
}

primary=$(get_output_name $internal)
secondary=$(get_output_name $external)

if is_output_connected $primary; then
  params="$params --output $primary --primary --mode $internal_resolution --rotate normal"
  [ -n "$secondary" ] && params="$params --${position}-of $secondary"
fi
if is_output_connected $secondary; then
  params="$params --output $secondary --mode $external_resolution --rotate normal"
else
  params="$params --output $secondary --off"
fi
echo $params
xrandr $params
wallpaper
