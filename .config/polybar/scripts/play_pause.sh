#!/bin/bash

status=$(playerctl status)

if [ $status = "Paused" ]; then
    polybar-msg hook spotify-play-pause 1
elif [ $status = "Playing" ]; then
    polybar-msg hook spotify-play-pause 2
fi

playerctl play-pause -p spotify
