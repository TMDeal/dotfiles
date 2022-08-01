#!/bin/bash

# https://github.com/PrayagS/polybar-spotify

CHAR_COUNT=30

# see man zscroll for documentation of the following parameters
zscroll -l $CHAR_COUNT \
        --delay 0.1 \
        --scroll-padding "  " \
        --match-command "`dirname $0`/get_spotify_status.sh --status" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --update-check true "`dirname $0`/get_spotify_status.sh" &

wait

