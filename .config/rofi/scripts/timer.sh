#!/usr/bin/env bash

# Style
dir="$HOME/.config/rofi/launchers/"
theme='style'

# Define menu items as "Label|Function Name"
MENU_ITEMS=(
    "Set Timer|set"
    "1 Minute|1min"
    "5 Minute|5min"
    "10 Minute|10min"
    "15 Minute|15min"
    "30 Minute|30min"
    "60 Minute|60min"
)

# Define functions for each menu item

set() {
    duration=$(rofi -dmenu -p "Timer duration in Minutes:" -theme "${dir}/${theme}.rasi")
    sleep $duration && notify-send --expire-time=9999 "Timer Finshed"
}

1min() {
    sleep 60 && notify-send --expire-time=9999 "Timer Finshed"
}

5min() {
    sleep 300 && notify-send --expire-time=9999 "Timer Finshed"
}

10min() {
    sleep 600 && notify-send --expire-time=9999 "Timer Finshed"
}

15min() {
    sleep 900 && notify-send --expire-time=9999 "Timer Finshed"
}

30min() {
    sleep 1800 && notify-send --expire-time=9999 "Timer Finshed"
}

60min() {
    sleep 3600 && notify-send --expire-time=9999 "Timer Finshed"
}

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
    IFS="|" read -r label _ <<<"$item"
    echo "$label"
done | rofi -dmenu -p "Timer" -theme ${dir}/${theme}.rasi)

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
    IFS="|" read -r label func <<<"$item"
    if [[ "$CHOICE" == "$label" ]]; then
        "$func"
        exit 0
    fi
done

exit 1
