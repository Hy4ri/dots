#!/usr/bin/env bash
set -euo pipefail

# Define menu items as "Label|Function Name"
MENU_ITEMS=(
  "🖥️ CPU Usage|get_cpu_usage"
  "🎮 GPU Usage|get_gpu_usage"
  "🧠 RAM Usage|get_ram_usage"
  "💾 Disk Usage|get_disk_usage"
  "🔋 Battery Status|get_battery_status"
  "  Show All Stats|show_all_stats"
)

# System monitoring functions
get_cpu_usage() {
  CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
  notify-send "CPU Usage" "🖥️ CPU: ${CPU_USAGE}%" -i "cpu"
}

get_gpu_usage() {
  if command -v nvidia-smi &>/dev/null; then
    GPU_USAGE=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
    notify-send "GPU Usage" "🎮 GPU: ${GPU_USAGE}%" -i "nvidia"
  else
    notify-send "GPU Usage" "🎮 GPU: N/A" -i "gpu"
  fi
}

get_ram_usage() {
  RAM_TOTAL=$(free -h | awk '/^Mem:/ {print $2}')
  RAM_USED=$(free -h | awk '/^Mem:/ {print $3}')
  RAM_PERCENT=$(free | awk '/^Mem:/ {printf "%.0f", $3/$2 * 100}')
  notify-send "RAM Usage" "🧠 RAM: ${RAM_USED}/${RAM_TOTAL} (${RAM_PERCENT}%)" -i "memory"
}

get_disk_usage() {
  echo "💾 Disk Usage:"
  DISK_INFO=$(df -h | awk '/^\/dev/ {printf "  %s: %s/%s (%s)\n", $6, $3, $2, $5}')
  echo "$DISK_INFO" | rofi -dmenu -p "System Stats" -no-fixed-num-lines
}

get_battery_status() {
  if command -v upower &>/dev/null; then
    battery_info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)
    if [[ $? -eq 0 ]]; then
      percentage=$(echo "$battery_info" | grep "percentage" | awk '{print $2}' | tr -d '%')
      state=$(echo "$battery_info" | grep "state" | awk '{print $2}')

      # Choose emoji based on battery level and status
      if [[ "$state" == "charging" ]]; then
        emoji="🔌"
      elif ((percentage <= 20)); then
        emoji="🪫"
      elif ((percentage <= 50)); then
        emoji="🔋"
      else
        emoji="🔋"
      fi

      notify-send "Battery Status" "${emoji} Battery: ${percentage}% (${state^})" -i "battery"
    else
      notify-send "Battery Status" "🔋 Battery: N/A" -i "battery"
    fi
  else
    notify-send "Battery Status" "🔋 Battery: N/A (upower not installed)" -i "battery"
  fi
}

show_all_stats() {
  # Collect stats
  CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
  RAM_TOTAL=$(free -h | awk '/^Mem:/ {print $2}')
  RAM_USED=$(free -h | awk '/^Mem:/ {print $3}')
  RAM_PERCENT=$(free | awk '/^Mem:/ {printf "%.0f", $3/$2 * 100}')
  DISK_INFO=$(df -h | awk '/^\/dev/ {printf "  %s: %s/%s (%s)\n", $6, $3, $2, $5}')

  # Get battery info
  if command -v upower &>/dev/null; then
    battery_info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)
    if [[ $? -eq 0 ]]; then
      percentage=$(echo "$battery_info" | grep "percentage" | awk '{print $2}' | tr -d '%')
      state=$(echo "$battery_info" | grep "state" | awk '{print $2}')

      if [[ "$state" == "charging" ]]; then
        emoji="🔌"
      elif ((percentage <= 20)); then
        emoji="🪫"
      elif ((percentage <= 50)); then
        emoji="🔋"
      else
        emoji="🔋"
      fi
      BATTERY_INFO="${emoji} Battery: ${percentage}% (${state^})"
    else
      BATTERY_INFO="🔋 Battery: N/A"
    fi
  else
    BATTERY_INFO="🔋 Battery: N/A"
  fi

  # Build output for rofi
  {
    echo "🖥️ CPU: ${CPU_USAGE}%"
    if command -v nvidia-smi &>/dev/null; then
      GPU_USAGE=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
      echo "🎮 GPU: ${GPU_USAGE}%"
    fi
    echo "🧠 RAM: ${RAM_USED}/${RAM_TOTAL} (${RAM_PERCENT}%)"
    echo "$BATTERY_INFO"
    echo "-------------------"
    echo "💾 Storage:"
    echo "$DISK_INFO"
  } | rofi -dmenu -p "System Stats" -no-fixed-num-lines
}

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "System Monitor" -i)

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label func <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$func"
    exit 0
  fi
done

exit 1
