#!/bin/bash

function test {
    echo Ola trap
}
trap test HUP




echo "^fg(red)^bg(white)$TEST" | dzen2 -p -w 100 -fn 'FiraCode Nerd Font Mono:size=20'
