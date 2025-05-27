#!/usr/bin/env bash

# Style
dir="$HOME/.config/rofi/launchers/"
theme='style'

# Configs
STEAM_DIR="$HOME/.steam/steam"
HEROIC_INSTALLED_JSON="$HOME/.config/heroic/legendaryConfig/legendary/installed.json"
ROFI_CMD="rofi -dmenu -i -p Games -theme ${dir}/${theme}.rasi -show-icons"
ICON_CACHE="$HOME/.cache/game_launcher_icons"

mkdir -p "$ICON_CACHE"
declare -A GAME_MAP
rofi_entries=()

######################
# 1. Steam Games
######################
mapfile -t steam_names < <(grep -h '"name"' "$STEAM_DIR/steamapps"/appmanifest_*.acf | sed 's/.*"name"\s*"\(.*\)"/\1/')
mapfile -t steam_ids < <(basename -s .acf "$STEAM_DIR/steamapps"/appmanifest_*.acf | sed 's/appmanifest_//')

for i in "${!steam_names[@]}"; do
  name="${steam_names[$i]}"
  id="${steam_ids[$i]}"
  if [[ "$name" =~ [Pp]roton|[Ss]team|[Rr]untime|[Cc]ompatibility|[Tt]ool ]]; then
    continue
  fi

  icon_path="$STEAM_DIR/appcache/librarycache/${id}_library_600x900.jpg"
  fallback_icon="/usr/share/icons/hicolor/48x48/apps/steam.png"

  if [[ -f "$icon_path" ]]; then
    convert "$icon_path" -resize 48x48 "$ICON_CACHE/$id.png" 2>/dev/null
    icon="$ICON_CACHE/$id.png"
  else
    icon="$fallback_icon"
  fi

  label="Steam: $name"
  GAME_MAP["$label"]="steam -applaunch $id"
  rofi_entries+=("$label\x00icon\x1f$icon")
done

######################
# 2. Heroic Games
######################
if [[ -f "$HEROIC_INSTALLED_JSON" ]]; then
  while read -r key; do
    title=$(jq -r --arg key "$key" '.[$key].title' "$HEROIC_INSTALLED_JSON")
    if [[ "$title" != "null" ]]; then
      label="Heroic: $title"
      GAME_MAP["$label"]="heroic --launch $key"
      # Attempt to use cover image if available in Heroic cache
      cover_img="$HOME/.cache/heroic/thumbnails/$key.jpg"
      fallback_icon="/usr/share/icons/hicolor/48x48/apps/heroic.png"
      if [[ -f "$cover_img" ]]; then
        convert "$cover_img" -resize 48x48 "$ICON_CACHE/heroic_$key.png" 2>/dev/null
        icon="$ICON_CACHE/heroic_$key.png"
      else
        icon="$fallback_icon"
      fi
      rofi_entries+=("$label\x00icon\x1f$icon")
    fi
  done < <(jq -r 'keys[]' "$HEROIC_INSTALLED_JSON")
fi

######################
# 3. Lutris Games
######################
if command -v lutris &>/dev/null; then
  while read -r name; do
    label="Lutris: $name"
    GAME_MAP["$label"]="lutris lutris:rungame/$name"
    # Try to get an icon for Lutris games
    icon_path="$HOME/.local/share/icons/hicolor/48x48/apps/lutris-${name// /_}.png"
    fallback_icon="/usr/share/icons/hicolor/48x48/apps/lutris.png"
    if [[ -f "$icon_path" ]]; then
      icon="$icon_path"
    else
      icon="$fallback_icon"
    fi
    rofi_entries+=("$label\x00icon\x1f$icon")
  done < <(lutris -l)
fi

######################
# Rofi Menu
######################
choice=$(printf '%b\n' "${rofi_entries[@]}" | sort | $ROFI_CMD)

[[ -n "$choice" ]] && eval "${GAME_MAP[$choice]}" &
