#!/bin/bash

# Get the used power profile
profile=$(powerprofilesctl get)

# Change the active mode
if [ "$profile" = "balanced" ] || [ "$profile" = "power-saver" ]; then
  powerprofilesctl set performance
  notify-send -t 500 "Performance mode"
  echo "Performance mode"
else
    powerprofilesctl set balanced
    notify-send -t 500 "Balanced mode"
    echo "Balanced mode"
fi
