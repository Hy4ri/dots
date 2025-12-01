#!/usr/bin/env bash
set -euo pipefail

# Initialize state variable
bar_visible=true

# Monitor cursor position
while true; do
    # Get cursor position using hyprctl
    # Use -j for JSON output to be robust
    Y=$(hyprctl -j cursorpos | jq '.y')
    
    if [ "$Y" -le 5 ] && [ "$bar_visible" = true ]; then
        pkill -SIGUSR2 .waybar-wrapped || true
        bar_visible=false
        while [ "$Y" -le 35 ]; do
            sleep 0.2
            Y=$(hyprctl -j cursorpos | jq '.y')
        done
    elif [ "$Y" -gt 35 ] && [ "$bar_visible" = false ]; then
        pkill -SIGUSR1 .waybar-wrapped || true
        bar_visible=true
    fi
    sleep 0.5
done
