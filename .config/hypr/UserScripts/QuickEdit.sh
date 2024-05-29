#!/bin/bash
# Rofi menu for Quick Edit / View of Settings (SUPER E)

configs="$HOME/.config/hypr/configs"
UserConfigs="$HOME/.config/hypr/UserConfigs"

menu(){
  printf "1. view Env-variables\n"
  printf "2. view Window-Rules\n"
  printf "3. view Startup_Apps\n"
  printf "4. view User-Keybinds\n"
  printf "5. view Monitors\n"
  printf "6. view Laptop-Keybinds\n"
  printf "7. view User-Settings\n"
  printf "8. view Default-Settings\n"
  printf "9. view Default-Keybinds\n"
  printf "10. view laptop-Monitor\n" 
}

main() {
    choice=$(menu | rofi -i -dmenu -config ~/.config/rofi/config-confedit.rasi | cut -d. -f1)
    case $choice in
        1)
            foot -e nvim "$UserConfigs/ENVariables.conf"
            ;;
        2)
            foot -e nvim "$UserConfigs/WindowRules.conf"
            ;;
        3)
            foot -e nvim "$UserConfigs/Startup_Apps.conf"
            ;;
        4)
            foot -e nvim "$UserConfigs/UserKeybinds.conf"
            ;;
        5)
            foot -e nvim "$UserConfigs/Monitors.conf"
            ;;
        6)
            foot -e nvim "$UserConfigs/Laptops.conf"
            ;;
        7)
            foot -e nvim "$UserConfigs/UserSettings.conf"
            ;;
        8)
            foot -e nvim "$configs/Settings.conf"
            ;;
        9)
            foot -e nvim "$configs/Keybinds.conf"
            ;;
        10)
            foot -e nvim "$UserConfigs/LaptopDisplay.conf"
            ;;    
        *)
            ;;
    esac
}

main