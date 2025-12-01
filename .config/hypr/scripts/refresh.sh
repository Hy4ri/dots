#!/usr/bin/env bash

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

# Coordinates for wlsunset
LAT="32.0346"
LONG="35.7269"

waybar &
wlsunset -l "$LAT" -L "$LONG" &
dunst &
foot --server &

exit 0
