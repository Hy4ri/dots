#!/usr/bin/env bash
# Screenshots scripts

# Dependencies
deps=(grim slurp wl-copy jq notify-send hyprctl)
for dep in "${deps[@]}"; do
    if ! command -v "$dep" &> /dev/null; then
        echo "Error: '$dep' is not installed."
        exit 1
    fi
done

# Variables
notify_cmd_shot="notify-send -h string:x-canonical-private-synchronous:shot-notify -u low"
time=$(date "+%Y-%m-%d.%I:%M:%S")
dir="${HOME}/Pictures/Screenshots"
file="${time}.png"

# Ensure directory exists
mkdir -p "$dir"

# Notification function
notify_view() {
    local msg="$1"
    if [[ -e "$dir/$file" ]]; then
        ${notify_cmd_shot} "$msg"
    else
        ${notify_cmd_shot} "Screenshot NOT Saved."
    fi
}

# Core screenshot function
take_shot() {
    local geom="$1"
    local output="$2"

    if [[ -n "$geom" ]]; then
        grim -g "$geom" -l0 "$output"
    else
        grim -l0 "$output"
    fi
}

# Actions
shotnow() {
    cd "${dir}" && take_shot "" - | tee "$file" | wl-copy
    notify_view "Screenshot Saved."
}

check_swappy_config() {
    local swappy_config="${HOME}/.config/swappy/config"
    if [[ ! -f "$swappy_config" ]]; then
        mkdir -p "${HOME}/.config/swappy"
        cat > "$swappy_config" <<EOF
[Default]
save_dir=$HOME/Pictures/Screenshots
save_filename_format=%Y-%m-%d.%H:%M:%S.png
show_panel=false
line_size=5
text_size=20
text_font=JetBrainsMono Nerd Font
paint_mode=brush
early_exit=false
fill_shape=false
EOF
    fi
}

shotswappy() {
    check_swappy_config
 
    local geometry
    geometry=$(slurp)
 
    if [[ -z "$geometry" ]]; then
        return
    fi

    local tmpfile
    tmpfile=$(mktemp)
 
    take_shot "$geometry" "$tmpfile" && ${notify_cmd_shot} "Screenshot Captured."
    swappy -f - < "$tmpfile"
    rm "$tmpfile"
}

# Main execution
case "$1" in
    --now)
        shotnow
        ;;
    --swappy)
        shotswappy
        ;;
    *)
        echo -e "Available Options : --now --swappy"
        exit 1
        ;;
esac

exit 0
