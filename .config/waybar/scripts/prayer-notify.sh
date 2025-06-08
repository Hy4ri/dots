#!/bin/bash

# Store the path to the prayer-times script
script="$HOME/.config/waybar/scripts/prayer-times"

#sync
$script check

# Get the current prayer
current=$($script current)

# Get the current prayer
next=$($script next)

# Get the remaining time
remaining=$($script remaining)

# Convert the remaining time to seconds
remaining_seconds=$(echo "$remaining" | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')

# Check if remaining time is between 0 and 30 seconds
if [ "$remaining_seconds" -le 30 ] && [ "$remaining_seconds" -ge 0 ]; then
    notify-send "  $next in $remaining"
fi
