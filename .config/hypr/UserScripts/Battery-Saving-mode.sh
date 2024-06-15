#!/bin/bash

# Get battery status directory (assuming single battery)
battery_dir="/sys/class/power_supply/BAT0"

# Check if directory exists (handle potential errors)
if [ ! -d "$battery_dir" ]; then
  echo "Error: Battery directory not found at $battery_dir"
  exit 1
fi

# Get battery status
status=$(cat "$battery_dir"/status)

# Display charging state and potentially update config using hyprctl (assuming functionality)
if [ "$status" = "Charging" ] || [ "$status" = "Full" ] ; then
  hyprctl reload
  powerprofilesctl set performance
  sleep 1
  notify-send "Battery Saving mode: OFF"
  echo "Battery Saving mode: OFF"
else
  hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1
  sleep 1
  hyprctl keyword animations:enabled 0;
  sleep 1
  hyprctl --batch "\ 
      keyword decoration:drop_shadow 0;\
      keyword decoration:blur:enabled 0;\
      keyword general:gaps_in 0;\
      keyword general:gaps_out 0;\
      keyword general:border_size 0;\
      keyword decoration:rounding 0";\
  sleep 1
  powerprofilesctl set power-saver
  sleep 1
  notify-send "Battery Saving mode: ON"
  echo "Battery Saving mode: ON"
fi
