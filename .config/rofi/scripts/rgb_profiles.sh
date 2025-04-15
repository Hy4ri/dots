#!/usr/bin/env bash

# Style
dir="$HOME/.config/rofi/launchers/type-3"
theme='style-5'

# Define menu items as "Label|Function Name"
MENU_ITEMS=(
    "🟨 Yellow|yellow"
    "🟥 Crimson|crimson"
)

yellow() {
    openrgb -p Yellow
    sleep 0.2
    notify-send -a "Profile" "RGB set to Yellow"
}

crimson() {
    openrgb -p Crimson
    sleep 0.2
    notify-send -a "Profile" "RGB set to Crimson"
}

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
    IFS="|" read -r label _ <<<"$item"
    echo "$label"
done | rofi -dmenu -p "Set RGB Profile" -theme ${dir}/${theme}.rasi)

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
    IFS="|" read -r label func <<<"$item"
    if [[ "$CHOICE" == "$label" ]]; then
        "$func"
        exit 0
    fi
done

exit 1
