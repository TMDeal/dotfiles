#/bin/bash

# kill existing instance
killall -q polybar

# wait until fully dead
while pgrep -x polybar >/dev/null; do sleep 1; done

# run it again
polybar --reload top 2>$HOME/.config/polybar/logs &
