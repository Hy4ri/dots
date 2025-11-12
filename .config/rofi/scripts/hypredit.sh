#!/usr/bin/env bash

Configs="$HOME/.config/hypr/configs"
Scripts="$HOME/.config/hypr/scripts"
hypr="$HOME/.config/hypr/"
term="foot"

menu() {
  printf "1. view Hyprland-Settings\n"
  printf "2. view Window-Rules\n"
  printf "3. view Keybinds\n"
  printf "4. view Appbinds\n"
  printf "5. view Scripts\n"
  printf "6. view Startup_Apps\n"
  printf "7. view Env-variables\n"
  printf "8. view Hypr Folder\n"
  printf "9. view Monitors\n"
  printf "10. view Laptop-Settings\n"
  printf "11. view Settings-wal\n"
  printf "12. view Main config \n"
}

main() {
  choice=$(menu | rofi -i -dmenu | cut -d. -f1)
  case $choice in
  1)
    $term nvim "$Configs/settings.conf"
    ;;
  2)
    $term nvim "$Configs/windowrules.conf"
    ;;
  3)
    $term nvim "$Configs/keybinds.conf"
    ;;
  4)
    $term nvim "$Configs/appbinds.conf"
    ;;
  5)
    $term nvim $Scripts
    ;;
  6)
    $term nvim "$Configs/autostart.conf"
    ;;
  7)
    $term nvim "$Configs/env.conf"
    ;;
  8)
    $term nvim "$hypr"
    ;;
  9)
    $term nvim "$Configs/monitors.conf"
    ;;
  10)
    $term nvim "$Configs/laptops.conf"
    ;;
  11)
    $term nvim "$Configs/settings-wal.conf"
    ;;
  12)
    $term nvim ~/.config/hypr/hyprland.conf
    ;;
  *) ;;
  esac
}

main
