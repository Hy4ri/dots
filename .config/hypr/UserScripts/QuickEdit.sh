#!/bin/bash
# Rofi menu for Quick Edit / View of Settings (SUPER E)

Configs="$HOME/.config/hypr/Configs"

menu(){
  printf "1. view Hyprland-Settings\n"
  printf "2. view Window-Rules\n"
  printf "3. view Keybinds\n"
  printf "4. view Startup_Apps\n"
  printf "5. view Env-variables\n"
  printf "6. view Monitors\n"
  printf "7. view Laptop-Settings\n"
}

main() {
    choice=$(menu | rofi -i -dmenu -theme $HOME/.config/rofi/launchers/type-3/style-5.rasi | cut -d. -f1)
    case $choice in
        1)
            foot -e nvim "$Configs/UserSettings.conf"
            ;;
        2)
            foot -e nvim "$Configs/WindowRules.conf"
            ;;
        3)
            foot -e nvim "$Configs/Keybinds.conf"
            ;;
        4)
            foot -e nvim "$Configs/Startup_Apps.conf"
            ;;
        5)
            foot -e nvim "$Configs/ENVariables.conf"
            ;;
        6)
            foot -e nvim "$Configs/Monitors.conf"
            ;;
        7)
            foot -e nvim "$Configs/Laptops.conf"
            ;;
        *)
            ;;
    esac
}

main
