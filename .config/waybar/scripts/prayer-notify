#!/bin/bash
set -euo pipefail

# Store the path to the prayer-times script
script="$HOME/.config/waybar/scripts/prayer-times"

#sync
"$script" check

# Get data in one go
data=$("$script" notify-data)
next=$(echo "$data" | jq -r '.next')
remaining_seconds=$(echo "$data" | jq -r '.remaining_seconds')

# Check if remaining time is between 0 and 30 seconds
if [ "$remaining_seconds" -le 30 ] && [ "$remaining_seconds" -ge 0 ]; then
    # Format seconds to HH:MM:SS
    printf -v remaining "%02d:%02d:%02d" $((remaining_seconds/3600)) $((remaining_seconds%3600/60)) $((remaining_seconds%60))
    notify-send "  $next in $remaining"
fi
