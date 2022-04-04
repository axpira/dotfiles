#!/usr/bin/env bash

# import ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg
#import -window {root, "$(xdo id)"}  ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg
#import -window {root, "$(xdotool getwindowfocus -f)"}  ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg

# [[ "$1" == "save" ]] && {
#     import ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg
#     exit 0
# }
# #import png:- | xclip -selection clipboard -t image/png
# #import ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg
# slop=$(slop -f "%g") || exit 1
# read -r G < <(echo $slop)
# import \
#     -window root \
#     -crop $G \
#     png:- \
#     | xclip -selection clipboard -t image/png
#     # ~/myimage.png
#mode="selection|window|root"
mode=${1:-selection}
options=""
case $mode in
  "selection") options="$options -s" ;;
  "window") options="$options -i $(xdotool getactivewindow)" ;;
  "root") options="$options" ;;
esac

#output="save|clipboard"
output=${2:-clipboard}

if [[ "$output" == "clipboard" ]]; then
  maim $options | xclip -selection clipboard -t image/png
else
  filePath="$HOME/screenshot/$(date +%Y%m%d_%H%M%S).png"
  if maim $options $filePath; then
    notify-send "screenshot saved $filePath"
  else
    notify-send -u critical "Error on took screenshot $filePath"
  fi
fi

# maim -s | xclip -selection clipboard -t image/png

#maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png
