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
wlsunset -l 32.0346 -L 35.7269 &
dunst &
foot --server &

exit 0
