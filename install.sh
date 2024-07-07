#!/bin/bash

clear

cat <<"EOF"

███╗   ███╗███████╗███████╗    ██████╗  ██████╗ ████████╗ ███████╗██╗██╗     ███████╗███████╗
████╗ ████║██╔════╝╚════██║    ██╔══██╗██╔═══██╗╚══██╔══╝ ██╔════╝██║██║     ██╔════╝██╔════╝
██╔████╔██║███████╗    ██╔╝    ██║  ██║██║   ██║   ██║    █████╗  ██║██║     █████╗  ███████╗
██║╚██╔╝██║╚════██║   ██╔╝     ██║  ██║██║   ██║   ██║    ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██║ ╚═╝ ██║███████║   ██║      ██████╔╝╚██████╔╝   ██║    ██║     ██║███████╗███████╗███████║
╚═╝     ╚═╝╚══════╝   ╚═╝      ╚═════╝  ╚═════╝    ╚═╝    ╚═╝     ╚═╝╚══════╝╚══════╝╚══════                                                                
EOF


######etc/pacman.conf
echo "edit pacman.conf"

pacman_conf="/etc/pacman.conf"

# Remove comments '#' from specific lines
lines_to_edit=(
    "Color"
    "CheckSpace"
    "VerbosePkgLists"
    "ParallelDownloads"
)

# Uncomment specified lines if they are commented out
for line in "${lines_to_edit[@]}"; do
    if grep -q "^#$line" "$pacman_conf"; then
        sudo sed -i "s/^#$line/$line/" "$pacman_conf"
        echo -e "${CAT} Uncommented: $line ${RESET}" 
    else
        echo -e "${CAT} $line is already uncommented. ${RESET}" 
    fi
done

# Add "ILoveCandy" below ParallelDownloads if it doesn't exist
if grep -q "^ParallelDownloads" "$pacman_conf" && ! grep -q "^ILoveCandy" "$pacman_conf"; then
    sudo sed -i "/^ParallelDownloads/a ILoveCandy" "$pacman_conf"
    echo -e "${CAT} Added ILoveCandy below ParallelDownloads. ${RESET}" 
else
    echo -e "${CAT} ILoveCandy already exists ${RESET}" 
fi

echo -e "${CAT} Pacman.conf spicing up completed ${RESET}" 

# updating pacman.conf
sudo pacman -Sy

clear
sleep 1

~/dots/scripts/./paru.sh
sleep 1
~/dots/scripts/./pipewire.sh
sleep 1
~/dots/scripts/./fonts.sh
sleep 1
~/dots/scripts/./packages.sh
sleep 1
~/dots/scripts/./hyprland.sh
sleep 1
~/dots/scripts/./nvidia.sh
sleep 1
~/dots/scripts/./Bluetooth.sh
sleep 1
~/dots/scripts/./sddm.sh
sleep 1
~/dots/scripts/./Zsh.sh
sleep 1

# input profile
while true; do
    echo "${WARN} This script will add your user to the 'input' group."
    echo "${NOTE} Please note that adding yourself to the 'input' group might be necessary for waybar keyboard-state functionality."

    if [[ -z $input_group_choid ]]; then
      read -p "${YELLOW}Do you want to proceed? (y/n): ${RESET}" input_group_choid
    fi

    if [[ $input_group_choid == "y" || $input_group_choid == "Y" ]]; then
        # Check if the 'input' group exists
        if grep -q '^input:' /etc/group; then
            echo "${OK} 'input' group exists."
        else
            echo "${NOTE} 'input' group doesn't exist. Creating 'input' group..."
            sudo groupadd input

            # Log the creation of the 'input' group
            echo "'input' group created" 
        fi

        # Add the user to the input group
        sudo usermod -aG input "$(whoami)"
        echo "${OK} User added to the 'input' group. Changes will take effect after you log out and log back in."

        # Log the addition of the user to the 'input' group
        echo "User added to 'input' group" 
        break  # Break out of the loop if 'yes' is chosen
    elif [[ $input_group_choid == "n" || $input_group_choid == "N" ]]; then
        echo "${NOTE} No changes made. Exiting the script."
        break  # Break out of the loop if 'no' is chosen
    else
        echo "${ERROR} Invalid choice. Please enter 'y' for yes or 'n' for no."
    fi
done

clear
sleep 1
cd ~/dots

### Dotfiles

# عمل نسخة احتياطية لملفاتك الاصلية
sudo mv ~/.config ~/config-backup

sleep 0.5

cd ~/dots
cp -r .config ~/.config
cp -r .icons ~/.icons
cp -r .local ~/.local
cp -r .themes ~/.themes
mv ~/dots/wallpapers ~/Pictures/wallpapers
cp -r .zshrc ~/
cp -r .zprofile ~/

###done 

bat <<"EOF"
██████╗  ██████╗ ███╗   ██╗███████╗
██╔══██╗██╔═══██╗████╗  ██║██╔════╝
██║  ██║██║   ██║██╔██╗ ██║█████╗  
██║  ██║██║   ██║██║╚██╗██║██╔══╝  
██████╔╝╚██████╔╝██║ ╚████║███████╗
╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝
EOF


echo "Reboot in 10s"
sleep 10 

systemctl reboot