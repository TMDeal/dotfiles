dir="$HOME/.config/rofi/launchers/misc"
theme="$1"

if [ ! -f "$dir/themes/$theme.rasi" ]; then
    echo "Theme '$theme' does not exist!"
    exit 1
fi

rofi -no-lazy-grab -show drun -modi drun -theme "$dir/themes/$theme"
