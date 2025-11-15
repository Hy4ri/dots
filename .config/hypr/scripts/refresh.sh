#!/usr/bin/env bash

scripts=$HOME/.config/hypr/scripts

# Kill already running processes
_ps=(waybar rofi wlsunset foot dunst)
for _prs in "${_ps[@]}"; do
  if pidof "${_prs}" >/dev/null; then
    pkill "${_prs}"
  fi
done

sleep 0.3

#Refresh hyprland

hyprctl reload
hyprctl dispacth forcerendererreload

#Relunch

waybar &
wlsunset &
dunst &
foot --server &

exit 0
