#!/usr/bin/env bash

if [ -f /tmp/rofi_timer_target ]; then
    target=$(cat /tmp/rofi_timer_target)
    now=$(date +%s)
    remaining=$((target - now))

    if [ $remaining -gt 0 ]; then
        if [ $remaining -ge 3600 ]; then
            output=$(date -u -d "@${remaining}" +%H:%M:%S)
        else
            output=$(date -u -d "@${remaining}" +%M:%S)
        fi
        echo "{\"text\": \" $output\", \"tooltip\": \"Timer expires at $(date -d @$target +'%H:%M:%S')\", \"class\": \"running\"}"
    else
        rm -f /tmp/rofi_timer_target
        echo "{\"text\": \"\", \"tooltip\": \"\", \"class\": \"stopped\"}"
    fi
else
    echo "{\"text\": \"\", \"tooltip\": \"\", \"class\": \"stopped\"}"
fi
