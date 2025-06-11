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

[ ! -d ~/dots ] cp "$(pwd)" -r ~/dots
cd ~/dots

echo "edit pacman.conf"

pacman_conf="/etc/pacman.conf"

# Remove comments '#' from specific lines
lines_to_edit=(
    "Color"
    "CheckSpace"
    "VerbosePkgLists"
    "ParallelDownloads"
    "[multilib]"
    "Include = /etc/pacman.d/mirrorlist"
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

sleep 1

# Backup
echo -n "Backup /home? y/n:  "
read Backup

case "$Backup" in
yes | Yes | y | Y)
    [ -d ~/.config ] && mv ~/.config/ ~/old-config/
    [ -d ~/.icons ] && mv ~/.icons/ ~/old-config/
    [ -d ~/.themes ] && mv ~/.themes/ ~/old-config/
    [ -d ~/.zshrc ] && mv ~/.zshrc ~/old-config/
    ;;
No | no | n | N) ;;
*) ;;
esac

cat <<"EOF"

 █████╗ ██╗   ██╗██████╗     ██╗  ██╗███████╗██╗     ██████╗ ███████╗██████╗
██╔══██╗██║   ██║██╔══██╗    ██║  ██║██╔════╝██║     ██╔══██╗██╔════╝██╔══██╗
███████║██║   ██║██████╔╝    ███████║█████╗  ██║     ██████╔╝█████╗  ██████╔╝
██╔══██║██║   ██║██╔══██╗    ██╔══██║██╔══╝  ██║     ██╔═══╝ ██╔══╝  ██╔══██╗
██║  ██║╚██████╔╝██║  ██║    ██║  ██║███████╗███████╗██║     ███████╗██║  ██║
╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝    ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝

EOF
while true; do
    echo "Choose a package manager to install: yay, paru, or both: "
    read -r helper

    case "$helper" in
    yay)
        export helper
        echo -n "installing $helper"
        ~/dots/scripts/./yay.sh
        break
        ;;
    paru)
        export helper
        echo -n "installing $helper"
        ~/dots/scripts/./paru.sh
        break
        ;;
    both)
        echo -n "installing yay"
        ~/dots/scripts/./yay.sh
        sleep 1
        export helper="paru"
        echo -n "installing paru"
        ~/dots/scripts/./paru.sh
        break
        ;;
    No | no | n | N) ;;
    *)
        echo "Invalid option. Please choose either 'yay', 'paru', or 'both'."
        ;;
    esac
done

#pipewire

cat <<"EOF"

██████╗ ██╗██████╗ ███████╗██╗    ██╗██╗██████╗ ███████╗
██╔══██╗██║██╔══██╗██╔════╝██║    ██║██║██╔══██╗██╔════╝
██████╔╝██║██████╔╝█████╗  ██║ █╗ ██║██║██████╔╝█████╗
██╔═══╝ ██║██╔═══╝ ██╔══╝  ██║███╗██║██║██╔══██╗██╔══╝
██║     ██║██║     ███████╗╚███╔███╔╝██║██║  ██║███████╗
╚═╝     ╚═╝╚═╝     ╚══════╝ ╚══╝╚══╝ ╚═╝╚═╝  ╚═╝╚══════╝

EOF

echo -n "Install pipewire? y/n: "
read pipewire

case "$pipewire" in
yes | Yes | y | Y)
    echo -n "installing pipewire"
    ~/dots/scripts/./pipewire.sh
    ;;
No | no | n | N) ;;
*) ;;
esac

sleep 1

cat <<"EOF"

███████╗ ██████╗ ███╗   ██╗████████╗
██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝
█████╗  ██║   ██║██╔██╗ ██║   ██║
██╔══╝  ██║   ██║██║╚██╗██║   ██║
██║     ╚██████╔╝██║ ╚████║   ██║
╚═╝      ╚═════╝ ╚═╝  ╚═══╝   ╚═╝

EOF

echo -n "Install required fonts? y/n: "
read font

case "$font" in
yes | Yes | y | Y)
    echo -n "installing the fonts"
    ~/dots/scripts/./fonts.sh
    ;;
No | no | n | N) ;;
*) ;;
esac

sleep 1

cat <<"EOF"

██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗██████╗
██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗
██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██████╔╝
██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██╔══██╗
╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║  ██║
 ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝

EOF

while true; do
    echo -n "chose a Windomanager:Hyprland, sway or both : "
    read Wm
    case "$Wm" in
    hyprland | Hyprland)
        echo -n "installing $Wm"
        ~/dots/scripts/./hyprland.sh
        break
        ;;
    sway | Sway)
        echo -n "installing $Wm"
        ~/dots/scripts/./sway.sh
        break
        ;;
    both | Both)
        echo -n "installing sway"
        ~/dots/scripts/./sway.sh
        sleep 1
        echo -n "installing hyprland"
        ~/dots/scripts/./hyprland.sh
        break
        ;;
    No | no | n | N) ;;
    *)
        echo "Invalid option. Please choose either 'hyprland', 'wayfire', 'sway' or 'all'."
        ;;
    esac
done

sleep 1

cat <<"EOF"

██████╗ ██╗███████╗██████╗ ██╗      █████╗ ██╗   ██╗    ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗██████╗
██╔══██╗██║██╔════╝██╔══██╗██║     ██╔══██╗╚██╗ ██╔╝    ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗
██║  ██║██║███████╗██████╔╝██║     ███████║ ╚████╔╝     ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██████╔╝
██║  ██║██║╚════██║██╔═══╝ ██║     ██╔══██║  ╚██╔╝      ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██╔══██╗
██████╔╝██║███████║██║     ███████╗██║  ██║   ██║       ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║  ██║
╚═════╝ ╚═╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝       ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝

EOF

echo -n "Chose a display manager? sddm,gdm,ly or none: "
read DisMan

case "$DisMan" in
sddm | SDDM | Sddm)
    echo -n "installing $DisMan"
    $helper -Sy --needed --noconfirm sddm
    systemctl enable sddm.service
    ;;
gdm | GDM | Gdm)
    echo -n "installing $DisMan"
    $helper -Sy --needed --noconfirm gdm
    systemctl enable gdm.service
    ;;
ly | Ly | LY)
    echo -n "installing $DisMan"
    $helper -Sy --needed --noconfirm ly
    systemctl enable ly.service
    ;;
None | none | n | N) ;;
esac

sleep 1

cat <<"EOF"

██████╗  █████╗  ██████╗██╗  ██╗ █████╗  ██████╗ ███████╗███████╗
██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔════╝ ██╔════╝██╔════╝
██████╔╝███████║██║     █████╔╝ ███████║██║  ███╗█████╗  ███████╗
██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══██║██║   ██║██╔══╝  ╚════██║
██║     ██║  ██║╚██████╗██║  ██╗██║  ██║╚██████╔╝███████╗███████║
╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝

EOF

echo -n "Install packages? y/n: "
read packages

case "$packages" in
yes | Yes | y | Y)
    echo -n "installing the packages"
    ~/dots/scripts/./packages.sh
    ;;
No | no | n | N) ;;
*) ;;
esac

sleep 1

cat <<"EOF"

 █████╗ ██╗   ██╗██████╗   ██████╗  █████╗  ██████╗██╗  ██╗ █████╗  ██████╗ ███████╗███████╗
██╔══██╗██║   ██║██╔══██╗  ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔════╝ ██╔════╝██╔════╝
███████║██║   ██║██████╔╝  ██████╔╝███████║██║     █████╔╝ ███████║██║  ███╗█████╗  ███████╗
██╔══██║██║   ██║██╔══██╗  ██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══██║██║   ██║██╔══╝  ╚════██║
██║  ██║╚██████╔╝██║  ██║  ██║     ██║  ██║╚██████╗██║  ██╗██║  ██║╚██████╔╝███████╗███████║
╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝  ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝

EOF
echo -n "Install AUR packages? y/n: "
read AURpackages

case "$AURpackages" in
yes | Yes | y | Y)
    echo -n "installing AUR packages"
    ~/dots/scripts/./aur-packages.sh
    ;;
No | no | n | N) ;;
*) ;;
esac

sleep 1

cat <<"EOF"

███████╗██╗      █████╗ ████████╗██████╗  █████╗ ██╗  ██╗
██╔════╝██║     ██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██║ ██╔╝
█████╗  ██║     ███████║   ██║   ██████╔╝███████║█████╔╝
██╔══╝  ██║     ██╔══██║   ██║   ██╔═══╝ ██╔══██║██╔═██╗
██║     ███████╗██║  ██║   ██║   ██║     ██║  ██║██║  ██╗
╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝


EOF

echo -n "Install Flatpaks? y/n: "
read Flatpaks

case "$Flatpaks" in
yes | Yes | y | Y)
    echo -n "installing the Flatpaks"
    ~/dots/scripts/./Flatpaks.sh
    ;;
No | no | n | N) ;;
*) ;;
esac

sleep 1

cat <<"EOF"

███╗   ██╗██╗   ██╗██╗██████╗ ██╗ █████╗
████╗  ██║██║   ██║██║██╔══██╗██║██╔══██╗
██╔██╗ ██║██║   ██║██║██║  ██║██║███████║
██║╚██╗██║╚██╗ ██╔╝██║██║  ██║██║██╔══██║
██║ ╚████║ ╚████╔╝ ██║██████╔╝██║██║  ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═════╝ ╚═╝╚═╝  ╚═╝

EOF

echo -n "Install NVIDIA's required packages? y/n: "
read NVIDIA

case "$NVIDIA" in
yes | Yes | y | Y)
    echo -n "installing NVIDIA's required packages"
    ~/dots/scripts/./nvidia.sh
    ;;
No | no | n | N) ;;
*) ;;
esac

sleep 1

cat <<"EOF"

██████╗ ██╗     ██╗   ██╗███████╗████████╗ ██████╗  ██████╗ ████████╗██╗  ██╗
██╔══██╗██║     ██║   ██║██╔════╝╚══██╔══╝██╔═══██╗██╔═══██╗╚══██╔══╝██║  ██║
██████╔╝██║     ██║   ██║█████╗     ██║   ██║   ██║██║   ██║   ██║   ███████║
██╔══██╗██║     ██║   ██║██╔══╝     ██║   ██║   ██║██║   ██║   ██║   ██╔══██║
██████╔╝███████╗╚██████╔╝███████╗   ██║   ╚██████╔╝╚██████╔╝   ██║   ██║  ██║
╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝  ╚═════╝    ╚═╝   ╚═╝  ╚═╝
EOF

echo -n "Install Bluetooth? y/n: "
read Bluetooth

case "$Bluetooth" in
yes | Yes | y | Y)
    echo -n "installing Bluetooth"
    ~/dots/scripts/./Bluetooth.sh
    ;;
No | no | n | N) ;;
*) ;;
esac

cat <<"EOF"

██████╗ ██████╗ ██╗███╗   ██╗████████╗███████╗██████╗
██╔══██╗██╔══██╗██║████╗  ██║╚══██╔══╝██╔════╝██╔══██╗
██████╔╝██████╔╝██║██╔██╗ ██║   ██║   █████╗  ██████╔╝
██╔═══╝ ██╔══██╗██║██║╚██╗██║   ██║   ██╔══╝  ██╔══██╗
██║     ██║  ██║██║██║ ╚████║   ██║   ███████╗██║  ██║
╚═╝     ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
EOF

echo -n "Install Printers support? y/n: "
read Printers

case "$Printers" in
yes | Yes | y | Y)
    echo -n "installing Printers support"
    ~/dots/scripts/./Printer.sh
    ;;
No | no | n | N) ;;
*) ;;
esac

sleep 1

### Dotfiles

echo -n "Apply Dotfiles? y/n:  "
read Dotfiles

case "$Dotfiles" in
yes | Yes | y | Y)
    papirus-folders -C carmine --theme Papirus-Dark
    [ ! -d ~/Documents ] && mkdir ~/Documents/Projects/dots/ && cp ~/dots -r ~/Documents/Projects/dots/
    ~/dots/scripts/./symlink.sh
    cd ~/dots
    cp -r .icons ~/
    cp -r .themes ~/
    cd ~/.icons
    tar -xvzf Bibata-Modern-Ice.tar.gz
    cd ~/.themes
    tar -xvzf M57.tar.gz
    mkdir -p ~/Pictures/
    cd ~/Pictures/
    git clone https://github.com/hy4ri/wallpapers
    ;;
No | no | n | N) ;;
*) ;;
esac

sleep 1

cat <<"EOF"

███████╗███████╗██╗  ██╗
╚══███╔╝██╔════╝██║  ██║
  ███╔╝ ███████╗███████║
 ███╔╝  ╚════██║██╔══██║
███████╗███████║██║  ██║
╚══════╝╚══════╝╚═╝  ╚═╝

EOF

echo -n "Install Zsh? y/n: "
read Zsh

case "$Zsh" in
yes | Yes | y | Y)
    echo -n "installing Zsh"
    ~/dots/scripts/./Zsh.sh
    ;;
No | no | n | N) ;;
*) ;;
esac

sleep 1

rm -rf ~/dots

cat <<"EOF"
██████╗  ██████╗ ███╗   ██╗███████╗
██╔══██╗██╔═══██╗████╗  ██║██╔════╝
██║  ██║██║   ██║██╔██╗ ██║█████╗
██║  ██║██║   ██║██║╚██╗██║██╔══╝E
██████╔╝╚██████╔╝██║ ╚████║███████╗
╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝
EOF

echo "Rebooting in 10s"
sleep 10 && systemctl reboot
