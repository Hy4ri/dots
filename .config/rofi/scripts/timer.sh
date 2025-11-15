#!/usr/bin/env bash

menu() {
  printf "1. Custom Timer\n"
  printf "2. 1 Minute\n"
  printf "3. 5 Minutes\n"
  printf "4. 10 Minutes\n"
  printf "5. 15 Minutes\n"
  printf "6. 20 Minutes\n"
  printf "7. 30 Minutes\n"
  printf "8. 60 Minutes\n"
}

set() {
  duration=$(rofi -dmenu -p "Timer duration in Minutes:")
  time=$(echo "$duration * 60" | bc)
  notify-send "Timer Started" && sleep $time && notify-send --expire-time=9999 "Timer Finshed" "$duration Minute Timer is up!"
}

main() {
  choice=$(menu | rofi -i -dmenu -p "Select Timer:" | cut -d. -f1)

  case $choice in
    1) set ;;
    2) notify-send "Timer Started" && sleep 60 && notify-send --expire-time=9999 "Timer Finshed" "1 Minute is up!" ;;
    3) notify-send "Timer Started" && sleep 300 && notify-send --expire-time=9999 "Timer Finshed" "5 Minutes is up!" ;;
    4) notify-send "Timer Started" && sleep 600 && notify-send --expire-time=9999 "Timer Finshed" "10 Minutes is up!" ;;
    5) notify-send "Timer Started" && sleep 900 && notify-send --expire-time=9999 "Timer Finshed" "15 Minutes is up!" ;;
    6) notify-send "Timer Started" && sleep 1200 && notify-send --expire-time=9999 "Timer Finshed" "20 Minutes is up!" ;;
    7) notify-send "Timer Started" && sleep 1800 && notify-send --expire-time=9999 "Timer Finshed" "30 Minutes is up!" ;;
    8) notify-send "Timer Started" && sleep 3600 && notify-send --expire-time=9999 "Timer Finshed" "60 Minutes is up!" ;; 
    *);;
  esac
}

main
exit 1
