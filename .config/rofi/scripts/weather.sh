#!/usr/bin/env bash

# Style
dir="$HOME/.config/rofi/launchers/type-3"
theme='style-5'

# Define menu items as "Label|Function Name"
MENU_ITEMS=(
    "As-Salt|salt"
    "Amman|amman"
)

salt() {
    weather=$(curl -s 'v2.wttr.in/As-salt?format=3')
    notify-send "Weather" "$weather"

}

amman() {
    weather=$(curl -s 'v2.wttr.in/amman?format=3')
    notify-send "Weather" "$weather"

}


# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
    IFS="|" read -r label _ <<<"$item"
    echo "$label"
done | rofi -dmenu -p "Chose a city" -theme ${dir}/${theme}.rasi)

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
    IFS="|" read -r label func <<<"$item"
    if [[ "$CHOICE" == "$label" ]]; then
        "$func"
        exit 0
    fi
done

exit 1
