#!/usr/bin/env bash

# Define menu items as "Label|Function Name"
MENU_ITEMS=(
  "Calendar|calendar"
  "Colors|color"
  "Fonts|font"
)

# Define functions for each menu item

calendar() {
  THEDATE=$(yad --calendar)
  yad --text="You chose $THEDATE"
}

color() {
  yad --color
}

font() {
  yad --font
}

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "Yad tools" -i)

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label func <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$func"
    exit 0
  fi
done

exit 1
