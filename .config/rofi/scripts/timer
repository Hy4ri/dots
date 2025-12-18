#!/usr/bin/env bash
set -euo pipefail

# Define menu items
MENU_ITEMS=(
  "1. Custom Timer|set_custom"
  "2. 1 Minute|set_1"
  "3. 5 Minutes|set_5"
  "4. 10 Minutes|set_10"
  "5. 15 Minutes|set_15"
  "6. 20 Minutes|set_20"
  "7. 30 Minutes|set_30"
  "8. 60 Minutes|set_60"
  "9. Stopwatch|set_stopwatch"
)

TIMER_FILE="/tmp/rofi_timer_data"
STOPWATCH_FILE="/tmp/rofi_stopwatch_data"

# manage_timer background process
# $1: duration in seconds
# $2: original duration for message
manage_timer() {
  sleep "$1"
  notify-send --expire-time=9999 "Timer Finished" "$2 Minute Timer is up!"
  rm -f "$TIMER_FILE"
}

set_timer() {
  local duration=$1
  local time=$((duration * 60))
  local target=$(($(date +%s) + time))
  
  # Kill existing timer process if it exists
  if [ -f "$TIMER_FILE" ]; then
    local old_pid=$(sed -n '5p' "$TIMER_FILE")
    if [[ -n "$old_pid" && "$old_pid" -gt 0 ]] && kill -0 "$old_pid" 2>/dev/null; then
       kill "$old_pid"
    fi
  fi

  # Start background process
  (manage_timer "$time" "$duration") &
  local pid=$!
  
  # Write state: MODE, TARGET, STATUS, PAUSED_VAL, PID
  printf "TIMER\n%s\nRUNNING\n0\n%s" "$target" "$pid" > "$TIMER_FILE"
  notify-send "Timer Started" "$duration Minutes"
}

set_custom() {
  duration=$(rofi -dmenu -p "Timer duration in Minutes:")
  if [[ -n "$duration" && "$duration" =~ ^[0-9]+$ ]]; then
    set_timer "$duration"
  fi
}

set_1() { set_timer 1; }
set_5() { set_timer 5; }
set_10() { set_timer 10; }
set_15() { set_timer 15; }
set_20() { set_timer 20; }
set_30() { set_timer 30; }
set_60() { set_timer 60; }

set_stopwatch() {
  # Kill existing stopwatch process/state if it exists
  if [ -f "$STOPWATCH_FILE" ]; then
    # Stopwatches usually have PID 0 in state file, but check anyway
    local old_pid=$(sed -n '5p' "$STOPWATCH_FILE")
    if [[ -n "$old_pid" && "$old_pid" -gt 0 ]] && kill -0 "$old_pid" 2>/dev/null; then
       kill "$old_pid"
    fi
  fi
  
  local start=$(date +%s)
  printf "STOPWATCH\n%s\nRUNNING\n0\n0" "$start" > "$STOPWATCH_FILE"
  notify-send "Stopwatch Started"
}

toggle_pause() {
  local active=0
  
  # Toggle Timer
  if [ -f "$TIMER_FILE" ]; then
    active=1
    # local mode=$(sed -n '1p' "$TIMER_FILE")
    local target=$(sed -n '2p' "$TIMER_FILE")
    local status=$(sed -n '3p' "$TIMER_FILE")
    local paused_val=$(sed -n '4p' "$TIMER_FILE")
    local pid=$(sed -n '5p' "$TIMER_FILE")
    local now=$(date +%s)

    if [[ "$status" == "RUNNING" ]]; then
       # Pause Timer
       local remaining=$((target - now))
       if [[ -n "$pid" && "$pid" -gt 0 ]] && kill -0 "$pid" 2>/dev/null; then
         kill "$pid"
       fi
       printf "TIMER\n0\nPAUSED\n%s\n0" "$remaining" > "$TIMER_FILE"
    else
       # Resume Timer
       local new_target=$((now + paused_val))
       local duration_minutes=$((paused_val / 60)) 
       if [ "$duration_minutes" -eq 0 ]; then duration_minutes="<1"; fi
       (manage_timer "$paused_val" "$duration_minutes") &
       local new_pid=$!
       printf "TIMER\n%s\nRUNNING\n0\n%s" "$new_target" "$new_pid" > "$TIMER_FILE"
    fi
  fi

  # Toggle Stopwatch
  if [ -f "$STOPWATCH_FILE" ]; then
    active=1
    local start=$(sed -n '2p' "$STOPWATCH_FILE")
    local status=$(sed -n '3p' "$STOPWATCH_FILE")
    local paused_val=$(sed -n '4p' "$STOPWATCH_FILE")
    local now=$(date +%s)

    if [[ "$status" == "RUNNING" ]]; then
      # Pause Stopwatch
      local elapsed=$((now - start))
      printf "STOPWATCH\n0\nPAUSED\n%s\n0" "$elapsed" > "$STOPWATCH_FILE"
    else
      # Resume Stopwatch
      local new_start=$((now - paused_val))
      printf "STOPWATCH\n%s\nRUNNING\n0\n0" "$new_start" > "$STOPWATCH_FILE"
    fi
  fi

  if [ "$active" -eq 0 ]; then
     notify-send "No active timer/stopwatch"
  fi
}

stop_timer() {
  local stopped=0
  if [ -f "$TIMER_FILE" ]; then
    local pid=$(sed -n '5p' "$TIMER_FILE")
    if [[ -n "$pid" && "$pid" -gt 0 ]] && kill -0 "$pid" 2>/dev/null; then
      kill "$pid"
    fi
    rm -f "$TIMER_FILE"
    stopped=1
  fi
  
  if [ -f "$STOPWATCH_FILE" ]; then
    # Stopwatch usually has PID 0, but check just in case
    local pid=$(sed -n '5p' "$STOPWATCH_FILE")
    if [[ -n "$pid" && "$pid" -gt 0 ]] && kill -0 "$pid" 2>/dev/null; then
      kill "$pid"
    fi
    rm -f "$STOPWATCH_FILE"
    stopped=1
  fi

  if [ "$stopped" -eq 1 ]; then
    notify-send "Timer/Stopwatch Stopped"
  fi
}

# Handle Arguments
if [[ "${1:-}" == "--toggle-pause" ]]; then
  toggle_pause
  exit 0
fi

if [[ "${1:-}" == "--stop" ]]; then
  stop_timer
  exit 0
fi

if [[ "${1:-}" == "--stopwatch" ]]; then
  set_stopwatch
  exit 0
fi

if [[ "${1:-}" == "--timer" ]]; then
  if [[ -n "${2:-}" ]]; then
      set_timer "$2"
      exit 0
  fi
fi

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "Select Timer" -i)

# Match selection
for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label func <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$func"
    exit 0
  fi
done

exit 1
