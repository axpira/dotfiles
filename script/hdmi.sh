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
# xrandr \
#     --output $internal --mode 3840x2160 --pos 0x0    --auto \
#     --output $external  --mode 1920x1080 --pos 3840x0 --auto \
#         --panning 3840x2160+3840+0 --scale 2.0x2.0 \
#     --fb 7680x2400
# exit 1
# xrandr --output $internal --auto --output $external --auto --scale 2x2 --right-of $internal
# xrandr --output $internal --auto --output $external --auto --panning 3840x2160+3840+0 --scale 2x2 --right-of $internal
# exit 1
#--mode 1920x1080 \
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
            --scale 1.0x1.0 \
            --rotate normal
            #--panning 3840x2160+0+0
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
