#!/usr/bin/env bash
set -euo pipefail

# Game Launcher Scriptgs
HEROIC_INSTALLED_JSON="$HOME/.config/heroic/legendaryConfig/legendary/installed.json"
ROFI_CMD="rofi -dmenu -i -p Games -show-icons"
ICON_CACHE="$HOME/.cache/game_launcher_icons"

mkdir -p "$ICON_CACHE"

declare -A GAME_MAP
rofi_entries=()

######################
# Function to find Steam directories
######################
find_steam_dirs() {
  local steam_dirs=()

  # Common Steam installation paths
  local common_paths=(
    "$HOME/.steam/steam"
    "/opt/steam"
  )

  # Check common paths first
  for path in "${common_paths[@]}"; do
    if [[ -d "$path/steamapps" ]]; then
      steam_dirs+=("$path")
    fi
  done

  # Search all mounted drives for Steam installations
  while IFS= read -r mount_point; do
    # Skip if mount point is empty, virtual filesystem, or already checked
    [[ -z "$mount_point" ]] && continue
    [[ "$mount_point" =~ ^/(proc|sys|dev|run|tmp) ]] && continue

    # Check for Steam in common locations on each drive
    local potential_paths=(
      "$mount_point/Steam"
      "$mount_point/steam"
      "$mount_point/SteamLibrary"
      "$mount_point/Games/Steam"
      "$mount_point/Program Files (x86)/Steam"
      "$mount_point/Program Files/Steam"
    )

    for steam_path in "${potential_paths[@]}"; do
      if [[ -d "$steam_path/steamapps" ]]; then
        steam_dirs+=("$steam_path")
      fi
    done

    # Also search for steamapps directories directly
    if command -v find &>/dev/null; then
      while IFS= read -r steamapps_dir; do
        local parent_dir=$(dirname "$steamapps_dir")
        if [[ -d "$steamapps_dir" && ! " ${steam_dirs[@]} " =~ " ${parent_dir} " ]]; then
          steam_dirs+=("$parent_dir")
        fi
      done < <(find "$mount_point" -maxdepth 3 -type d -name "steamapps" 2>/dev/null | head -10)
    fi

  done < <(findmnt -rno TARGET 2>/dev/null | grep -v "^/$" | sort -u)

  # Remove duplicates and print
  printf '%s\n' "${steam_dirs[@]}" | sort -u
}


######################
# 1. Steam Games (Multi-Drive)
######################
echo "Scanning for Steam installations..."

while IFS= read -r steam_dir; do
  echo "Found Steam installation: $steam_dir"

  # Skip if steamapps directory doesn't exist
  [[ ! -d "$steam_dir/steamapps" ]] && continue

  # Get game names and IDs from this Steam installation
  mapfile -t steam_names < <(grep -h '"name"' "$steam_dir/steamapps"/appmanifest_*.acf 2>/dev/null | sed 's/.*"name"\s*"\(.*\)"/\1/')
  mapfile -t steam_ids < <(basename -s .acf "$steam_dir/steamapps"/appmanifest_*.acf 2>/dev/null | sed 's/appmanifest_//')

  for i in "${!steam_names[@]}"; do
    name="${steam_names[$i]}"
    id="${steam_ids[$i]}"

    # Skip tools, Proton, and Steam components
    if [[ "$name" =~ [Pp]roton|[Ss]team|[Rr]untime|[Cc]ompatibility|[Tt]ool ]]; then
      continue
    fi

    # Try to find icon in current Steam installation
    icon_path="$steam_dir/appcache/librarycache/${id}_library_600x900.jpg"
    fallback_icon="/usr/share/icons/hicolor/48x48/apps/steam.png"

    if [[ -f "$icon_path" ]]; then
      if command -v convert &>/dev/null; then
        convert "$icon_path" -resize 48x48 "$ICON_CACHE/$id.png" 2>/dev/null
        icon="$ICON_CACHE/$id.png"
      else
        icon="$icon_path"
      fi
    else
      icon="$fallback_icon"
    fi

    # Create unique label to avoid conflicts between different Steam installations
    steam_location=$(basename "$(dirname "$steam_dir")")
    if [[ "$steam_location" == "steam" ]]; then
      steam_location=$(basename "$(dirname "$(dirname "$steam_dir")")")
    fi

    label="Steam ($steam_location): $name"

    # Avoid duplicate entries
    # if [[ -z "${GAME_MAP["$label"]}" ]]; then
    #   GAME_MAP["$label"]="steam -applaunch $id"
    #   rofi_entries+=("$label\x00icon\x1f$icon")
    # fi
  done

done < <(find_steam_dirs)

######################
# 2. Heroic Games
######################
if [[ -f "$HEROIC_INSTALLED_JSON" ]]; then
  echo "Processing Heroic games..."
  while read -r key; do
    title=$(jq -r --arg key "$key" '.[$key].title' "$HEROIC_INSTALLED_JSON")
    if [[ "$title" != "null" ]]; then
      label="Heroic: $title"
      GAME_MAP["$label"]="heroic --launch $key"

      # Attempt to use cover image if available in Heroic cache
      cover_img="$HOME/.cache/heroic/thumbnails/$key.jpg"
      fallback_icon="/usr/share/icons/hicolor/48x48/apps/heroic.png"

      if [[ -f "$cover_img" ]]; then
        if command -v convert &>/dev/null; then
          convert "$cover_img" -resize 48x48 "$ICON_CACHE/heroic_$key.png" 2>/dev/null
          icon="$ICON_CACHE/heroic_$key.png"
        else
          icon="$cover_img"
        fi
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
  echo "Processing Lutris games..."
  while read -r id _ name _; do
    [[ -z "$name" ]] && continue

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
  done < <(lutris -l 2>/dev/null)
fi

######################
# Rofi Menu
######################
if [[ ${#rofi_entries[@]} -eq 0 ]]; then
  echo "No games found!"
  exit 1
fi

echo "Found ${#rofi_entries[@]} games total."

choice=$(printf '%b\n' "${rofi_entries[@]}" | sort | $ROFI_CMD)

if [[ -n "$choice" ]]; then
  # Extract the label (remove icon information)
  label=$(echo "$choice" | sed 's/\x00icon\x1f.*//')

  # Execute the corresponding command
  if [[ -n "${GAME_MAP["$label"]}" ]]; then
    echo "Launching: $label"
    eval "${GAME_MAP["$label"]}" &
  else
    echo "Error: No command found for '$label'"
    exit 1
  fi
fi
