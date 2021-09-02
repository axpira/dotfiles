#!/bin/bash


# ##I would like to use Nouveau for offloading the Intel card
# xrandr --setprovideroffloadsink nouveau modesetting
# #If the second GPU has outputs that aren't accessible by the primary GPU, you can use "Reverse PRIME" to make use of them. This will involve using the primary GPU to render the images, and then pass them off to the secondary GPU
# xrandr --setprovideroutputsource nouveau modesetting
# xrandr --output HDMI-1-1 --auto --above eDP-1
# #bspc monitor HDMI-1-1 -d X


# #xrandr --output HDMI-1-1 --off


# glxinfo | grep "OpenGL vendor string"
# export DRI_PRIME=1
# glxinfo | grep "OpenGL vendor string"
    # --dpi 276 \
    # --fb 7040x3960 \
if [ "$1" == "on" ]; then
    bspc monitor eDP-1 -d 4 5 6 7 8 9 0
    bspc monitor HDMI-1-1 -d 1 2 3
    xrandr \
        --output eDP-1 \
            --primary \
            --mode 3840x2160 \
            --pos 1920x0 \
            --rotate normal \
        --output HDMI-1-1 \
            --mode 1920x1080 \
            --pos 0x0 \
            --rotate normal \
            --scale 1x1 \
        --output DP-1-1 --off \
        --output DP-1-2 --off
else
    xrandr \
        --output eDP-1 \
            --primary \
            --mode 3840x2160 \
            --pos 1920x0 \
            --rotate normal \
        --output HDMI-1-1 --off \
        --output DP-1-1 --off \
        --output DP-1-2 --off
    bspc monitor eDP-1 -d 1 2 3 4 5 6 7 8 9 0
fi
# bspc monitor eDP-1 -d I II III IV V
# #bspc monitor HDMI-1-1 -d 6
