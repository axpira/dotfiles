#!/bin/bash

/sbin/iwlist wlan0 scan | grep ESSID | cut -d":" -f2 | tr -d '"' | dmenu -i -l 10
