#!/bin/bash

INTERVAL=1800 # 30 minutes in seconds

change_wallpaper() {
    hyprwall | awk '/Wallpaper set successfully/ {print $NF}' | sed 's|~|'$HOME'|' > ~/Desktop/pic.txt && ln -sf "$(cat ~/Desktop/pic.txt)" ~/Desktop/.pic | wal -i ~/Desktop/.pic
    rm ~/Desktop/pic.txt ~/Desktop/.pic
    hyprctl hyprpaper unload unused
}

auto_change_wallpaper() {
    while true; do
        #hyprwall --random --backend hyprpaper
        hyprwall --random | awk '/Random wallpaper set successfully/ {print $NF}' | sed 's|~|'$HOME'|' > ~/Desktop/pic.txt && ln -sf "$(cat ~/Desktop/pic.txt)" ~/Desktop/.pic | wal -i ~/Desktop/.pic
        rm ~/Desktop/pic.txt ~/Desktop/.pic
        sleep $INTERVAL
        hyprctl hyprpaper unload unused
    done
}

change_wallpaper_random() {
    hyprwall --random | awk '/Random wallpaper set successfully/ {print $NF}' | sed 's|~|'$HOME'|' > ~/Desktop/pic.txt && ln -sf "$(cat ~/Desktop/pic.txt)" ~/Desktop/.pic | wal -i ~/Desktop/.pic
    rm ~/Desktop/pic.txt ~/Desktop/.pic
    hyprctl hyprpaper unload unused
}

if [[ "$1" == "--auto" ]]; then
    auto_change_wallpaper
elif [[ "$1" == "--random" ]]; then
    change_wallpaper_random
elif [[ "$1" == "-h" ]]; then
    echo -e "Available Options : --random --auto"
else
	change_wallpaper
fi
