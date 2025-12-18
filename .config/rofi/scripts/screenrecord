#!/usr/bin/env bash
set -euo pipefail

# Check dependencies
for cmd in slurp wf-recorder; do
    if ! command -v $cmd &>/dev/null; then
        notify-send "Error" "$cmd is not installed"
        exit 1
    fi
done

# === Paths ===
DIR="$HOME/Videos/Screenrecords"
mkdir -p "$DIR"
TIMESTAMP=$(date "+%Y-%m-%d.%H-%M-%S")
OUT="$DIR/$TIMESTAMP.mp4"
PID_FILE="/tmp/screenrecording.pid"
FRAME="30"

# Define menu items as "Label|Function Name"
MENU_ITEMS=(
  "Monitor|monitor"
  "Custom Region|region"
  "Stop|stop_recording"
)

# === Functions ===
region() {
  GEO=$(slurp)
  wf-recorder -a -r "$FRAME" -g "$GEO" -f "$OUT" &
  notify-send "Recording Started"
  echo $! >"$PID_FILE"
}

monitor() {
  # Get list of monitors
  MONS=$(hyprctl monitors -j | jq -r '.[].name')
  MON=$(echo "$MONS" | rofi -dmenu -p "Select Monitor")

  [[ -z "$MON" ]] && exit 1 # User cancelled

  wf-recorder -a -r "$FRAME" -o "$MON" -f "$OUT" &
  notify-send "Screen Recording" "Recording Started"
  echo $! >"$PID_FILE"
}

stop_recording() {
  if [[ -f "$PID_FILE" ]]; then
    PID=$(cat "$PID_FILE")
    if ps -p "$PID" > /dev/null; then
        kill "$PID" && rm "$PID_FILE"
        notify-send "Screen Recording" "Recording stopped"
    else
        rm "$PID_FILE"
        notify-send "Screen Recording" "Recording process not found (stale PID file removed)"
    fi
  else
    notify-send "Screen Recording" "No recording in progress"
  fi
}

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "Screen Recorder" -i)

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label func <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$func"
    exit 0
  fi
done

exit 1
