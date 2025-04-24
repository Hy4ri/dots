#!/usr/bin/env bash

# Style
dir="$HOME/.config/rofi/launchers/type-3"
theme='style-5'

# Define menu items as "Label|Function Name"
MENU_ITEMS=(
    "󰛨 100%|100"
    "󱩖 90%|90"
    "󱩕 80%|80"
    "󱩔 70%|70"
    "󱩓 60%|60"
    "󱩒 50%|50"
    "󱩑 40%|40"
    "󱩐 30%|30"
    "󱩏 20%|20"
    "󱩎 10%|10"
)

# Define functions for each menu item
100(){
    monitorctl b 100
    sleep 0.2
    notify-send -a "Brightness" "󰛨 100%"
}

90(){
    monitorctl b 90
    sleep 0.2
    notify-send -a "Brightness" "󱩖 90%"
}

80(){
    monitorctl b 80
    sleep 0.2
    notify-send -a "Brightness" "󱩕 80%"
}

70(){
    monitorctl b 70
    sleep 0.2
    notify-send -a "Brightness" "󱩔 70%"
}

60(){
    monitorctl b 60
    sleep 0.2
    notify-send -a "Brightness" "󱩓 60%"
}

50(){
    monitorctl b 50
    sleep 0.2
    notify-send -a "Brightness" "󱩒 50%"
}

40(){
    monitorctl b 40
    sleep 0.2
    notify-send -a "Brightness" "󱩑 40%"
}

30(){
    monitorctl b 30
    sleep 0.2
    notify-send -a "Brightness" "󱩐 30%"
}

20(){
    monitorctl b 20
    sleep 0.2
    notify-send -a "Brightness" "󱩏 20%"
}

10(){
    monitorctl b 10
    sleep 0.2
    notify-send -a "Brightness" "󱩎 10%"
}

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
    IFS="|" read -r label _ <<<"$item"
    echo "$label"
done | rofi -dmenu -p "Set Brightness" -theme ${dir}/${theme}.rasi)

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
    IFS="|" read -r label func <<<"$item"
    if [[ "$CHOICE" == "$label" ]]; then
        "$func"
        exit 0
    fi
done

exit 1
