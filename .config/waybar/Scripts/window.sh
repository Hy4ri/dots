#!/bin/bash

# Get the title of the active window
title=$(hyprctl activewindow | awk -F 'title: ' '/title:/ {print $2}')

# Check if a title was found
if [ -n "$title" ]; then
  # Print the title with actual newlines
  echo "$title" | sed 's/./&\n/g'
else
  # Fallback if no active window is found
  echo ""
fi
