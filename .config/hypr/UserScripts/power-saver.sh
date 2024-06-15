#!/bin/bash

# Get the used power profile
profile=$(powerprofilesctl get)

# Change the active mode
if [ "$profile" = "balanced" ] || [ "$profile" = "performance" ]; then
  powerprofilesctl set power-saver
  notify-send -t 500 "Power-saver mode"
  echo "Power-saver mode"
else
    powerprofilesctl set balanced
    notify-send -t 500 "balanced mode"
    echo "balanced mode"
fi
