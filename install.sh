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
cd ~/m57-dots-install


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

sleep 1

# Backup
echo -n "Backup /home? y/n:  "
read Backup

case "$Backup" in
  yes | Yes | y | Y)
    mv ~/.config/ ~/old-config/
    mv ~/.icons/ ~/old-config/
    mv ~/.themes/ ~/old-config/
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 0.5

#aur helper
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
      ~/m57-dots-install/scripts/./yay.sh
      break
    ;;
    paru)
      export helper
      echo -n "installing $helper"
      ~/m57-dots-install/scripts/./paru.sh
      break
    ;;
    both)
      echo -n "installing yay"
      ~/m57-dots-install/scripts/./yay.sh
      sleep 1
      export helper="paru"
      echo -n "installing paru"
      ~/m57-dots-install/scripts/./paru.sh
      break
    ;;
    No | no | n | N)
    ;;
    *)
      echo "Invalid option. Please choose either 'yay', 'paru', or 'both'."
    ;;
  esac
done


sleep 1

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
    ~/m57-dots-install/scripts/./pipewire.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

#Fonts

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
    ~/m57-dots-install/scripts/./fonts.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

#hyprland

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
      ~/m57-dots-install/scripts/./hyprland.sh
      break
    ;;
    sway | Sway)
      echo -n "installing $Wm"
      ~/m57-dots-install/scripts/./sway.sh
      break
    ;;
    both | Both )
      echo -n "installing sway"
      ~/m57-dots-install/scripts/./sway.sh
      sleep 1
      echo -n "installing hyprland"
      ~/m57-dots-install/scripts/./hyprland.sh
      break
    ;;
    No | no | n | N)
    ;;
    *)
      echo "Invalid option. Please choose either 'hyprland', 'wayfire', 'sway' or 'all'."
    ;;
  esac
done

sleep 1

#Display manager

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
  gdm | GDM | Gdm )
    echo -n "installing $DisMan"
    $helper -Sy --needed --noconfirm gdm
    systemctl enable gdm.service
  ;;
  ly | Ly | LY)
    echo -n "installing $DisMan"
    $helper -Sy --needed --noconfirm ly
    systemctl enable ly.service
  ;;
  None | none | n | N)
  ;;
esac

sleep 1

#packages

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
    ~/m57-dots-install/scripts/./packages.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

#Aurpackages

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
    ~/m57-dots-install/scripts/./aur-packages.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

#Flatpaks

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
    ~/m57-dots-install/scripts/./Flatpaks.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1


#nvidia

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
    ~/m57-dots-install/scripts/./nvidia.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

#Bluetooth

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
    ~/m57-dots-install/scripts/./Bluetooth.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

#Printer

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
    ~/m57-dots-install/scripts/./Printer.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

### Dotfiles

echo -n "Apply Dotfiles? y/n:  "
read Dotfiles

case "$Dotfiles" in
  yes | Yes | y | Y)
    papirus-folders -C carmine --theme Papirus-Dark
    cd ~/m57-dots-install
    cp -r .config ~/
    ~/m57-dots-install/scripts/./symlink.sh
    cp -r .icons ~/
    cp -r .local ~/
    cp -r .themes ~/
    cd ~/.icons
    tar -xvzf Bibata-Modern-Ice.tar.gz
    cd ~/.themes
    tar -xvzf M57.tar.gz
    cd ~/dots
    mkdir -p ~/Pictures/
    cd ~/Pictures/
    git clone https://github.com/hy4ri/wallpapers
    cd ~/m57-dots-install
    cp -r .zshrc ~/
    cp -r .zprofile ~/
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

#Zsh

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
    ~/m57-dots-install/scripts/./Zsh.sh
  ;;
  No | no | n | N)
  ;;
  *)
  ;;
esac

sleep 1

sudo rm -r ~/m57-dots-install

###done

bat <<"EOF"
██████╗  ██████╗ ███╗   ██╗███████╗
██╔══██╗██╔═══██╗████╗  ██║██╔════╝
██║  ██║██║   ██║██╔██╗ ██║█████╗
██║  ██║██║   ██║██║╚██╗██║██╔══╝E
██████╔╝╚██████╔╝██║ ╚████║███████╗
╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝
EOF

echo "Rebooting in 10s"
sleep 10 && systemctl reboot
