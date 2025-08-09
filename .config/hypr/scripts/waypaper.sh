#!/usr/bin/env bash

INTERVAL=1800 # 30 minutes in seconds

change_wallpaper() {
    waypaper | awk '/Wallpaper set successfully/ {print $NF}' | sed "s|~|$HOME|" >~/Desktop/pic.txt
    ln -sf "$(cat ~/Desktop/pic.txt)" ~/Desktop/.pic
    wal -i ~/Desktop/.pic
    rm ~/Desktop/pic.txt ~/Desktop/.pic
}

change_wallpaper_random() {
    waypaper --random --monitor eDP-1 | awk '/Random wallpaper set successfully/ {print $NF}' | sed "s|~|$HOME|" >~/Desktop/pic.txt
    ln -sf "$(cat ~/Desktop/pic.txt)" ~/Desktop/.pic
    wal -i ~/Desktop/.pic
    rm ~/Desktop/pic.txt ~/Desktop/.pic
}

change_wallpaper_auto() {
    while true; do
        sleep $INTERVAL
        waypaper --random --monitor eDP-1
    done
}

change_wallpaper_auto_wall() {
    while true; do
        waypaper --random | awk '/Random wallpaper set successfully/ {print $NF}' | sed "s|~|$HOME|" >~/Desktop/pic.txt
        ln -sf "$(cat ~/Desktop/pic.txt)" ~/Desktop/.pic
        wal -i ~/Desktop/.pic
        rm ~/Desktop/pic.txt ~/Desktop/.pic
        sleep $INTERVAL
    done
}

if [[ "$1" == "--auto" ]]; then
    change_wallpaper_auto
elif [[ "$1" == "--auto-wall" ]]; then
    change_wallpaper_auto_wall
elif [[ "$1" == "--random" ]]; then
    change_wallpaper_random
elif [[ "$1" == "--change" ]]; then
    change_wallpaper
else
    echo -e "Available Options : --change --random --auto"
fi
