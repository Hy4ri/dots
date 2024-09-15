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
  printf "8. view Wal Colors\n"
  printf "9. view Settings\n"
}

main() {
    choice=$(menu | rofi -i -dmenu -theme $HOME/.config/rofi/launchers/type-3/style-5.rasi | cut -d. -f1)
    case $choice in
        1)
            foot nvim "$Configs/UserSettings.conf"
            ;;
        2)
            foot nvim "$Configs/WindowRules.conf"
            ;;
        3)
            foot nvim "$Configs/Keybinds.conf"
            ;;
        4)
            foot nvim "$Configs/Startup_Apps.conf"
            ;;
        5)
            foot nvim "$Configs/ENVariables.conf"
            ;;
        6)
            foot nvim "$Configs/Monitors.conf"
            ;;
        7)
            foot nvim "$Configs/Laptops.conf"
            ;;
        8)
            foot nvim "$Configs/wal.conf"
            ;;
        9)
            foot nvim ~/.config/hypr/hyprland.conf
            ;;
        *)
            ;;
    esac
}

main
