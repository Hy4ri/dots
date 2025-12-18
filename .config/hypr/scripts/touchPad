#!/usr/bin/env bash

STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"
TOUCHPAD_DEVICE="dell09e1:00-04f3:30cb-touchpad"

# === Functions ===
enable_touchpad() {
    echo "true" >"$STATUS_FILE"
    notify-send -u low "Touchpad enabled"
    hyprctl keyword device\[$TOUCHPAD_DEVICE\]:enabled true
}

disable_touchpad() {
    echo "false" >"$STATUS_FILE"
    notify-send -u low "Touchpad disabled"
    hyprctl keyword device\[$TOUCHPAD_DEVICE\]:enabled false
}

# === Toggle Logic ===
if [[ ! -f "$STATUS_FILE" ]]; then
    enable_touchpad
else
    if [[ $(<"$STATUS_FILE") == "true" ]]; then
        disable_touchpad
    else
        enable_touchpad
    fi
fi
