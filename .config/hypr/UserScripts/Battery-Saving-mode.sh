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
  hyprctl --batch "\ 
      keyword monitor eDP-1,1920x1080@120,0x0,1;\
      keyword animations:enabled 1;\
      keyword decoration:drop_shadow 1;\
      keyword decoration:blur:enabled 1;\
      keyword general:gaps_in 1;\
      keyword general:gaps_out 1;\
      keyword general:border_size 1;\
      keyword decoration:rounding 1"
  sleep 1
  powerprofilesctl set performance
  sleep 1
  notify-send Battery Saving mode: OFF
  echo off
else
  hyprctl --batch "\ 
      keyword monitor eDP-1,1920x1080@60,0x0,1;\
      keyword animations:enabled 0;\
      keyword decoration:drop_shadow 0;\
      keyword decoration:blur:enabled 0;\
      keyword general:gaps_in 0;\
      keyword general:gaps_out 0;\
      keyword general:border_size 0;\
      keyword decoration:rounding 0"
  sleep 1
  powerprofilesctl set power-saver
  sleep 1
  notify-send Battery Saving mode: ON
  echo on
fi
