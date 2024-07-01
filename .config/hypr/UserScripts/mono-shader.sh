#!/bin/bash

# Get the used shader
shader=$(hyprshade current)

# Change the active shader
if [ "$shader" = "grayscale" ] ; then
  hyprshade off
  echo "off"
else
    hyprshade on grayscale 
    echo "on"
fi
