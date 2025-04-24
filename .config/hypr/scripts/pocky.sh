#!/usr/bin/env bash

INTERVAL=1800 # 30 minutes in seconds

change_wallpaper_auto() {
    while true; do
        pocky random eDP-1
        hyprctl hyprpaper unload unused
        sleep $INTERVAL
    done
}

if [[ "$1" == "--auto" ]]; then
    change_wallpaper_auto
else
	echo -e "Available Options : --auto"
fi
