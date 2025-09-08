#!/usr/bin/env bash

# Run hyprprop once and store the result
prop_json=$(hyprprop)

# Extract values from the stored JSON
class=$(jq -r '.class' <<<"$prop_json")
prop=$(jq -r '"class=\(.class)\ntitle=\(.title)\nxwayland=\(.xwayland)"' <<<"$prop_json")

# Copy class to clipboard
wl-copy $class

# Show notification
notify-send -t 3000 "$prop"
