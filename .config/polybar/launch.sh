#/bin/bash

killall -q polybar
polybar --reload top 2>$HOME/.config/polybar/logs
