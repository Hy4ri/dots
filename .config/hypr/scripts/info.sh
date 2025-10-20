#!/usr/bin/env bash

workspace=$(hyprctl activeworkspace | sed -n 's/.*workspace ID \([0-9]\+\).*/\1/p')
time=$(date +%I:%M)

notify-send "Info" "Workspace: $workspace \nTime: $time"
