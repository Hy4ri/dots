#!/bin/bash

INTERVAL=1800 # 30 minutes in seconds

change_wallpaper() {
    while true; do
        hyprwall --random --backend Swww
        sleep $INTERVAL
    done
}

change_wallpaper
