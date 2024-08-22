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


sudo cp "$(pwd)" -r ~/m57-dots-install

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

#aur helper

echo -n "Which aur helper do you want to install? yay - paru - both - none? "
read helper
case "$helper" in
  yay)
    echo -n "installing $helper"
    ~/m57-dots-install/scripts/./yay.sh
  ;;
  paru)
     echo -n "installing $helper"
    ~/dotm57-dots-installs/scripts/./paru.sh
  ;;
  both)
    echo -n "installing yay"
    ~/m57-dots-install/scripts/./yay.sh
    sleep 1
    echo -n "installing paru"
    ~/m57-dots-install/scripts/./paru.sh
  ;;
  none)
  ;;
  *)
  ;;
esac

sleep 1

#pipewire
echo -n "Install pipewire? y/n"
read pipewire

case "$pipewire" in
  yes | Yes | y | Y)
    echo -n "installing pipewire"
    ~/m57-dots-install/scripts/./pipewire.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

#Fonts
echo -n "Install required fonts? y/n"
read font

case "$font" in
  yes | Yes | y | Y)
    echo -n "installing the fonts"
    ~/m57-dots-install/scripts/./fonts.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

#hyprland
echo -n "Install hyprland? y/n"
read hyprland

case "$packhyprlandages" in
  yes | Yes | y | Y)
    echo -n "installing hyprland"
    ~/m57-dots-install/scripts/./hyprland.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

#packages
echo -n "Install required packages? y/n"
read packages

case "$packages" in
  yes | Yes | y | Y)
    echo -n "installing the packages"
    ~/m57-dots-install/scripts/./packages.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

#nvidia
echo -n "Install NVIDIA's required packages? y/n"
read NVIDIA

case "$NVIDIA" in
  yes | Yes | y | Y)
    echo -n "installing NVIDIA's required packages"
    ~/m57-dots-install/scripts/./nvidia.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

#Bluetooth
echo -n "Install Bluetooth? y/n"
read Bluetooth

case "$Bluetooth" in
  yes | Yes | y | Y)
    echo -n "installing Bluetooth"
    ~/m57-dots-install/scripts/./Bluetooth.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

#Bluetooth
echo -n "Install Bluetooth? y/n"
read Bluetooth

case "$Bluetooth" in
  yes | Yes | y | Y)
    echo -n "installing Bluetooth"
    ~/m57-dots-install/scripts/./Bluetooth.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

#Printer
echo -n "Install Printers support? y/n"
read Printers

case "$Printers" in
  yes | Yes | y | Y)
    echo -n "installing Printers support"
    ~/m57-dots-install/scripts/./Printer.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

#Zsh
echo -n "Install Zsh? y/n"
read Printers

case "$Zsh" in
  yes | Yes | y | Y)
    echo -n "installing Zsh"
    ~/m57-dots-install/scripts/./Zsh.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

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

# Backup
echo -n "Backup home? y/n"
read Backup

case "$Backup" in
  yes | Yes | y | Y)
    mv ~/ -r ~/old-config
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

sleep 0.5

cd ~/dots
cp -r .config ~/.config
cp -r .icons ~/.icons
cp -r .local ~/
cp -r .themes ~/.themes
mv ~/dots/wallpapers ~/Pictures
cp -r .zshrc ~/
cp -r .zprofile ~/

systemctl --user enable --now prayer-times.service

sudo rm -r ~/m57-dots-install

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
