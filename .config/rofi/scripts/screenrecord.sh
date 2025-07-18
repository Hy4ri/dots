#!/usr/bin/env bash

# === Style & Config ===
dir="$HOME/.config/rofi/launchers/"
theme='style'

# === Paths ===
DIR="$HOME/Videos/Screenrecords"
mkdir -p "$DIR"
TIMESTAMP=$(date "+%Y-%m-%d.%H-%M-%S")
OUT="$DIR/$TIMESTAMP.mp4"
PID_FILE="/tmp/screenrecording.pid"

# === Menu Items ===
MENU_ITEMS=(
    "Monitor|monitor"
    "Custom Region|region"
    "Stop|stop_recording"
)

# === Functions ===

FRAME="30"

region() {
    GEO=$(slurp)
    wf-recorder -a -r "$FRAME" -g "$GEO" -f "$OUT" &
    notify-send "Recording Started"
    echo $! >"$PID_FILE"
}

monitor() {
    # Get list of monitors
    MONS=$(hyprctl monitors -j | jq -r '.[].name')
    MON=$(echo "$MONS" | rofi -dmenu -p "Select Monitor" -theme ${dir}/${theme}.rasi)

    [[ -z "$MON" ]] && exit 1 # User cancelled

    wf-recorder -a -r "$FRAME" -o "$MON" -f "$OUT" &
    notify-send "Screen Recording" "Recording Started"
    echo $! >"$PID_FILE"
}

stop_recording() {
    if [[ -f "$PID_FILE" ]]; then
        kill "$(cat $PID_FILE)" && rm "$PID_FILE"
        notify-send "Screen Recording" "Recording stopped"
    else
        notify-send "Screen Recording" "No recording in progress"
    fi
}

# === Rofi Menu ===
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
    IFS="|" read -r label _ <<<"$item"
    echo "$label"
done | rofi -dmenu -p "Screen Recorder" -theme ${dir}/${theme}.rasi)

# === Call Matched Function ===
for item in "${MENU_ITEMS[@]}"; do
    IFS="|" read -r label func <<<"$item"
    if [[ "$CHOICE" == "$label" ]]; then
        "$func"
        exit 0
    fi
done

exit 1
