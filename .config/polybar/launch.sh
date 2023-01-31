#/bin/bash

# kill existing instance
killall -q polybar

# wait until fully dead
while pgrep -x polybar >/dev/null; do sleep 1; done

LOGDIR="$HOME/.cache/polybar/logs"

if [ ! -d "$LOGDIR" ]; then
    mkdir -p $LOGDIR
fi

for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload top 2>"$LOGDIR/$m.log" &
done
