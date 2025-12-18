#!/usr/bin/env bash

# Check the current status of Bluetooth
BLUETOOTH_STATUS=$(rfkill list bluetooth | grep -i 'Soft blocked: yes')

if [ -z "$BLUETOOTH_STATUS" ]; then
  # Bluetooth is on, turn it off
  rfkill block bluetooth
  echo "Bluetooth turned off"
else
  # Bluetooth is off, turn it on
  rfkill unblock bluetooth
  echo "Bluetooth turned on"
fi
