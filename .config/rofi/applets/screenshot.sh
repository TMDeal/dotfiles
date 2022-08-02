#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

type="$1"

echo $type | grep -E "applet|menu" > /dev/null
if [ ! $? -eq 0 ]; then
    type="menu"
fi

dir="$HOME/.config/rofi/applets/configs/$type"
rofi_command="rofi -theme $dir/screenshot.rasi"

cmd="flameshot"

# Error msg
msg() {
	rofi -theme "$HOME/.config/rofi/applets/styles/message.rasi" -e "Please install '$cmd' first."
}

# Options
screen=""
area=""

# Variable passed to rofi
options="$screen\n$area"

chosen="$(echo -e "$options" | $rofi_command -p $cmd -dmenu -selected-row 1)"
case $chosen in
    $screen)
        $cmd gui
		if [[ -f "/usr/bin/$cmd" ]]; then
            sleep1; $cmd screen
		else
			msg
		fi
        ;;
    $area)
        if [[ -f "/usr/bin/$cmd" ]]; then
            sleep 1; $cmd gui
		else
			msg
		fi
        ;;
esac

