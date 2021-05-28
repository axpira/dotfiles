#!/usr/bin/env bash

# import ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg
#import -window {root, "$(xdo id)"}  ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg
#import -window {root, "$(xdotool getwindowfocus -f)"}  ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg
#import ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg

#import png:- | xclip -selection clipboard -t image/png
#import ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg
slop=$(slop -f "%g") || exit 1
read -r G < <(echo $slop)
import \
    -window root \
    -crop $G \
    png:- \
    | xclip -selection clipboard -t image/png
    # ~/myimage.png
