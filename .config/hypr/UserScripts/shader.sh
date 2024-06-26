#!/bin/bash

# Get the used shader
shader=$(hyprshade current)

# Change the active shader
if [ "$shader" = "blue-light-filter" ] ; then
  hyprshade toggle
  echo " "
else
    hyprshade auto
    echo " "
fi
