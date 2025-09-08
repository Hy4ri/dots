#!/usr/bin/env bash

# Define menu items as "Label|Function Name"
MENU_ITEMS=(
  "Set Timer|set"
  "1 Minute|1min"
  "5 Minutes|5min"
  "10 Minutes|10min"
  "15 Minutes|15min"
  "20 Minutes|20min"
  "30 Minutes|30min"
  "60 Minutes|60min"
)

# Define functions for each menu item

set() {
  duration=$(rofi -dmenu -p "Timer duration in Minutes:")
  time=$(echo "$duration * 60" | bc)
  sleep $time && notify-send --expire-time=9999 "Timer Finshed" "$duration Minute Timer is up!"
}

1min() {
  sleep 60 && notify-send --expire-time=9999 "Timer Finshed" "1 Minute is up!"
}

5min() {
  sleep 300 && notify-send --expire-time=9999 "Timer Finshed" "5 Minutes is up!"
}

10min() {
  sleep 600 && notify-send --expire-time=9999 "Timer Finshed" "10 Minutes is up!"
}

15min() {
  sleep 900 && notify-send --expire-time=9999 "Timer Finshed" "15 Minutes is up!"
}

20min() {
  sleep 1200 && notify-send --expire-time=9999 "Timer Finshed" "20 Minutes is up!"
}

30min() {
  sleep 1800 && notify-send --expire-time=9999 "Timer Finshed" "30 Minutes is up!"
}

60min() {
  sleep 3600 && notify-send --expire-time=9999 "Timer Finshed" "60 Minutes is up!"
}

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "Timer")

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label func <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$func"
    exit 0
  fi
done

exit 1
