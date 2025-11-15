#!/usr/bin/env bash

notes_dir=~/Documents/Notes

MENU_ITEMS=(
  "Note List|list"
  "New note|new"
  "Delete note|remove"
)

new() {
  name=$(rofi -dmenu -p "Note name:")
  timestamp=$(date +%d-%m-%Y)

  [[ -z "$name" ]] && name="$timestamp"
  safe_name=$(echo "$name" | sed 's/[^a-zA-Z0-9._ -]/_/g' | tr ' ' '_')

  mkdir -p "$notes_dir"
  path="${notes_dir}/${safe_name}.md"

  touch "$path"
  foot -e nvim "$path"
}

list() {
  selected=$(ls -t ~/Documents/notes/ | rofi -dmenu)
  [[ -n "$selected" ]] && foot nvim $notes_dir/$selected
}

remove() {
  selected=$(ls -t ~/Documents/notes/ | rofi -dmenu)
  [[ -n "$selected" ]] && rm $notes_dir/$selected
  [[ -n "$selected" ]] && notify-send "Notes" "Deleted $selected"
}

CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "Notes")

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label func <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$func"
    exit 0
  fi
done

exit 1
