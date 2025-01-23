#!/usr/bin/env bash
# Use hyprpicker to pick a color and store it in a variable
color=$(hyprpicker -a)

# Use notify-send to display a notification with the picked color
notify-send "Picked Color" "$color"
