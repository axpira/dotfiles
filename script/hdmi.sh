#!/bin/bash


##I would like to use Nouveau for offloading the Intel card
xrandr --setprovideroffloadsink nouveau modesetting
#If the second GPU has outputs that aren't accessible by the primary GPU, you can use "Reverse PRIME" to make use of them. This will involve using the primary GPU to render the images, and then pass them off to the secondary GPU
xrandr --setprovideroutputsource nouveau modesetting
xrandr --output HDMI-1-1 --auto --above eDP-1
#bspc monitor HDMI-1-1 -d X


#xrandr --output HDMI-1-1 --off


glxinfo | grep "OpenGL vendor string"
export DRI_PRIME=1
glxinfo | grep "OpenGL vendor string"
