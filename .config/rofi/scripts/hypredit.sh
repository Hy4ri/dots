#!/usr/bin/env bash

Configs="$HOME/.config/hypr/Configs"
Scripts="$HOME/.config/hypr/scripts"
hypr="$HOME/.config/hypr/"
term="foot"

menu() {
  printf "1. view Hyprland-Settings\n"
  printf "2. view Scripts\n"
  printf "3. view Window-Rules\n"
  printf "4. view Keybinds\n"
  printf "5. view Startup_Apps\n"
  printf "6. view Env-variables\n"
  printf "7. view Hypr Folder\n"
  printf "8. view Monitors\n"
  printf "9. view Laptop-Settings\n"
  printf "10. view Settings-wal\n"
  printf "11. view Main config \n"
}

main() {
  choice=$(menu | rofi -i -dmenu | cut -d. -f1)
  case $choice in
  1)
    $term nvim "$Configs/Settings.conf"
    ;;
  2)
    $term nvim $Scripts
    ;;
  3)
    $term nvim "$Configs/WindowRules.conf"
    ;;
  4)
    $term nvim "$Configs/Keybinds.conf"
    ;;
  5)
    $term nvim "$Configs/Startup_Apps.conf"
    ;;
  6)
    $term nvim "$Configs/ENVariables.conf"
    ;;
  7)
    $term nvim "$hypr"
    ;;
  8)
    $term nvim "$Configs/Monitors.conf"
    ;;
  9)
    $term nvim "$Configs/Laptops.conf"
    ;;
  10)
    $term nvim "$Configs/Settings-wal.conf"
    ;;
  11)
    $term nvim ~/.config/hypr/hyprland.conf
    ;;
  *) ;;
  esac
}

main
