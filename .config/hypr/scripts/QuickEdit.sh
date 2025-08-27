#!/usr/bin/env bash
# Rofi menu for Quick Edit / View of Settings (SUPER E)

Configs="$HOME/.config/hypr/Configs"
Scripts="$HOME/.config/hypr/scripts"
term="foot"

menu() {
    printf "1. view Hyprland-Settings\n"
    printf "2. view Scripts\n"
    printf "3. view Window-Rules\n"
    printf "4. view Keybinds\n"
    printf "5. view Startup_Apps\n"
    printf "6. view Env-variables\n"
    printf "7. view Monitors\n"
    printf "8. view Laptop-Settings\n"
    printf "9. view UserSettings-wal\n"
    printf "10. view Main config \n"
}

main() {
    choice=$(menu | rofi -i -dmenu | cut -d. -f1)
    case $choice in
    1)
        $term nvim "$Configs/UserSettings.conf"
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
        $term nvim "$Configs/Monitors.conf"
        ;;
    8)
        $term nvim "$Configs/Laptops.conf"
        ;;
    9)
        $term nvim "$Configs/UserSettings-wal.conf"
        ;;
    10)
        $term nvim ~/.config/hypr/hyprland.conf
        ;;
    *) ;;
    esac
}

main
