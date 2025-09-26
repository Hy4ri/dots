#!/usr/bin/env bash

scripts=$HOME/.config/hypr/scripts

# Kill already running processes
_ps=(waybar rofi hyprsunset)
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
hyprsunset &

exit 0
