#!/usr/bin/env bash
set -euo pipefail

# Define menu items as "Label|Function Name"
MENU_ITEMS=(
  "1. Custom Timer|set_custom"
  "2. 1 Minute|set_1"
  "3. 5 Minutes|set_5"
  "4. 10 Minutes|set_10"
  "5. 15 Minutes|set_15"
  "6. 20 Minutes|set_20"
  "7. 30 Minutes|set_30"
  "8. 60 Minutes|set_60"
)

# Define functions for each menu item
set_custom() {
  duration=$(rofi -dmenu -p "Timer duration in Minutes:")
  if [[ -n "$duration" && "$duration" =~ ^[0-9]+$ ]]; then
    time=$(echo "$duration * 60" | bc)
    target=$(($(date +%s) + time))
    echo "$target" > /tmp/rofi_timer_target
    (notify-send "Timer Started" && sleep $time && notify-send --expire-time=9999 "Timer Finished" "$duration Minute Timer is up!" && rm -f /tmp/rofi_timer_target) &
  fi
}

set_timer() {
  local duration=$1
  local time=$((duration * 60))
  local target=$(($(date +%s) + time))
  echo "$target" > /tmp/rofi_timer_target
  (notify-send "Timer Started" && sleep $time && notify-send --expire-time=9999 "Timer Finished" "$duration Minute Timer is up!" && rm -f /tmp/rofi_timer_target) &
}

set_1() { set_timer 1; }
set_5() { set_timer 5; }
set_10() { set_timer 10; }
set_15() { set_timer 15; }
set_20() { set_timer 20; }
set_30() { set_timer 30; }
set_60() { set_timer 60; }

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "Select Timer" -i)

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label func <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$func"
    exit 0
  fi
done

exit 1
