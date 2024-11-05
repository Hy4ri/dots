#!/bin/bash

INTERVAL=1800 # 30 minutes in seconds

change_wallpaper() {
    while true; do
        hyprwall --random
        #~/.config/hypr/scripts/WalSwww.sh
        sleep $INTERVAL
        #hyprctl hyprpaper unload unused
    done
}

change_wallpaper
