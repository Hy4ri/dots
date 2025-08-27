#!/usr/bin/env bash

# Define menu items as "Label|Function Name"
MENU_ITEMS=(
  "Ai search|ai"
  "Web search|web"
  "Image search|image"
  "Video search|video"
  "Maps search|map"
)

# Define functions for each menu item

web() {
  search=$(rofi -dmenu -i -p "Google Web:")

  if [ -n "$search" ]; then
    encoded=$(printf '%s' "$search" | jq -sRr @uri)
    yad --html --browser \
      --uri="https://www.google.com/search?q=$encoded&udm=14&tbs=li:1" \
      --width=1280 \
      --height=980
  fi
}

image() {
  search=$(rofi -dmenu -i -p "Google images:")

  if [ -n "$search" ]; then
    encoded=$(printf '%s' "$search" | jq -sRr @uri)
    yad --html --browser \
      --uri="https://www.google.com/search?q=$encoded&udm=2&tbs=li:1" \
      --width=1280 \
      --height=980
  fi
}

map() {
  search=$(rofi -dmenu -i -p "Google Maps:")

  if [ -n "$search" ]; then
    encoded=$(printf '%s' "$search" | jq -sRr @uri)
    yad --html --browser \
      --uri="https://www.google.com/maps/search/$encoded" \
      --width=1280 \
      --height=980
  fi
}

video() {
  search=$(rofi -dmenu -i -p "Google videos:")

  if [ -n "$search" ]; then
    encoded=$(printf '%s' "$search" | jq -sRr @uri)
    yad --html --browser \
      --uri="https://www.google.com/search?q=$encoded&udm=7&tbs=li:1" \
      --width=1280 \
      --height=980
  fi
}

ai() {
  search=$(rofi -dmenu -i -p "Google videos:")
  if [ -n "$search" ]; then
    encoded=$(printf '%s' "$search" | jq -sRr @uri)
    yad --html --browser \
      --uri="https://www.perplexity.ai/?q=%s?q=$encoded" \
      --width=1280 \
      --height=980
  fi
}

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "search" -i)

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label func <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$func"
    exit 0
  fi
done

exit 1
