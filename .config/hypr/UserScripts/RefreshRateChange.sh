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
if [ "$status" = "Charging" ]; then
  hyprctl keyword monitor eDP-1,1920x1080@120,0x0,1
  sleep 1
  notify-send 120Hz
else
  hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1
  sleep 1
  notify-send 60Hz
fi
