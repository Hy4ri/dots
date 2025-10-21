#!/usr/bin/env bash

workspace=$(hyprctl activeworkspace | sed -n 's/.*workspace ID \([0-9]\+\).*/\1/p')
time=$(date +%I:%M)
day=$(date +%a\ %d/%m/%y)

notify-send "Info" "Workspace: $workspace
Time: $time
Date: $day"
