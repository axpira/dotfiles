#!/usr/bin/env bash

	# import ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg
	#import -window {root, "$(xdo id)"}  ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg
#	#import -window {root, "$(xdotool getwindowfocus -f)"}  ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg
#import ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg

#import png:- | xclip -selection clipboard -t image/png
import ~/screenshot/$(date +%Y%m%d_%H%M%S).jpg
