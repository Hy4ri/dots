#!/usr/bin/env bash

pid=$(pgrep gammastep)

if [[ $1 = "toggle" ]]; then
	if pgrep -x "gammastep" > /dev/null; then
		kill -9 $(pgrep -x "gammastep")&
        brightnessctl set 70%;
	else
		gammastep -O ${GAMMASTEP_NIGHT:-2000} &
        brightnessctl set 30%
	fi
fi

if pgrep -x "gammastep" > /dev/null; then
	echo "🌙"
	echo "Nightlight is on"
else
	echo "🔆"
	echo "Nightlight is off"
fi