#!/usr/bin/env bash

# Get the used shader
shader=$(hyprshade current)

# Change the active shader
if [ "$shader" = "blue-light-filter" ] ; then
  hyprshade off
  echo " "
else
    hyprshade on blue-light-filter
    echo " "
fi
