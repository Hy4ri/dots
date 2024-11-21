#!/bin/bash

INTERVAL=1800 # 30 minutes in seconds

change_wallpaper() {
    while true; do
        hyprwall --random --backend hyprpaper
        #hyprwall --random | awk '/Random wallpaper set successfully/ {print $NF}' | sed 's|~|'$HOME'|' > ~/Desktop/pic.txt && ln -sf "$(cat ~/Desktop/pic.txt)" ~/Desktop/.pic | wal -i ~/Desktop/.pic
        sleep $INTERVAL
        hyprctl hyprpaper unload unused
    done
}

change_wallpaper
