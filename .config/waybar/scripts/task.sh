#!/usr/bin/env bash

task=/tmp/rofi_task_data
output=$(cat "$task")
tooltip="Tasks to do"

exec() {
  echo "{\"text\": \"$output\", \"tooltip\": \"$tooltip\"}"
}

remove() {
  rm -f "$task"
}

case "$1" in
--remove)
  remove
  ;;
*)
  exec
  ;;
esac
