#!/usr/bin/env bash

workspace=$(hyprctl activeworkspace | sed -n 's/.*workspace ID \([0-9]\+\).*/\1/p')
time=$(date +%I:%M)
day=$(date +%a\ %d/%m/%y)
prayer=$(~/.config/waybar/scripts/prayer-times status | jq -r '.text')


notify-send "Info" "Workspace $workspace
$time
$day
$prayer"
