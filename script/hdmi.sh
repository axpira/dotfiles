#!/bin/bash

set -ex
external="HDMI-1-1"
internal="eDP-1"
# ##I would like to use Nouveau for offloading the Intel card
# xrandr --setprovideroffloadsink nouveau modesetting
# #If the second GPU has outputs that aren't accessible by the primary GPU, you can use "Reverse PRIME" to make use of them. This will involve using the primary GPU to render the images, and then pass them off to the secondary GPU
# xrandr --setprovideroutputsource nouveau modesetting
# xrandr --output HDMI-1-1 --auto --above eDP-1
# #bspc monitor HDMI-1-1 -d X


# #xrandr --output HDMI-1-1 --off


#exit 1
# glxinfo | grep "OpenGL vendor string"
# export DRI_PRIME=1
# glxinfo | grep "OpenGL vendor string"
    # --dpi 276 \
    # --fb 7040x3960 \
if [ "$1" == "on" ]; then
    xrandr \
        --dpi 192 \
        --output $internal \
            --primary \
            --mode 3840x2160 \
            --rotate normal \
            --right-of $external \
        --output $external \
            --mode 1920x1080 \
            --rotate normal
elif [ "$1" == "off" ]; then
    xrandr \
        --dpi 192 \
        --output $internal \
            --primary \
            --mode 3840x2160 \
            --rotate normal \
        --output $external --off
else
    if xrandr | grep HDMI | grep -q connected; then
        $0 on
    else
        $0 off
    fi
    exit 0
fi
# bspc monitor eDP-1 -d I II III IV V
# #bspc monitor HDMI-1-1 -d 6
wallpaper
