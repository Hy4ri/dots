#!/usr/bin/env bash

CLASS=genshinimpact.exe
PID_DIR=/tmp/hypr_sendkey
mkdir -p "$PID_DIR"

function toggle_function() {
    local func_name=$1
    local key=$2
    local pid_file="${PID_DIR}/${func_name}.pid"

    if [ -f "$pid_file" ]; then
        # If running, kill it
        pid=$(cat "$pid_file")
        if ps -p "$pid" > /dev/null; then
            kill "$pid"
        fi
        rm "$pid_file"
        notify-send "Toggled $func_name OFF"
    else
        # If not running, start it
        while true; do
            hyprctl dispatch sendkeystate ,"$key",down,class:$CLASS
            sleep 0.1
            hyprctl dispatch sendkeystate ,"$key",up,class:$CLASS
        done &
        echo $! > "$pid_file"
        notify-send "Toggled $func_name ON"
    fi
}

case "$1" in
    --chat)
        toggle_function "chat_accept" "f"
        ;;
    --walk)
        toggle_function "walk" "w"
        ;;
    *)
        echo "Usage: $0 {--chat|--walk}"
        exit 1
        ;;
esac
