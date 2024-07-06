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

cat <<"EOF"

██████╗  █████╗ ██████╗ ██╗   ██╗
██╔══██╗██╔══██╗██╔══██╗██║   ██║
██████╔╝███████║██████╔╝██║   ██║
██╔═══╝ ██╔══██║██╔══██╗██║   ██║
██║     ██║  ██║██║  ██║╚██████╔╝
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ 
                                 
EOF

if command -v paru &> /dev/null
    then
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si --noconfirm
        sleep 1
        paru -Syu --noconfirm
    else
        paru -Syu --noconfirm
    fi


clear
sleep 1

cd ~/


####FUNCTIONS

# Function for installing packages
install_package_pacman() {
  # Checking if package is already installed
  if pacman -Q "$1" &>/dev/null ; then
    echo -e "${OK} $1 is already installed. Skipping..."
  else
    # Package not installed
    echo -e "${NOTE} Installing $1 ..."
    sudo pacman -S --noconfirm "$1" 
    # Making sure package is installed
    if pacman -Q "$1" &>/dev/null ; then
      echo -e "${OK} $1 was installed."
    else
      # Something is missing, exiting to review log
      echo -e "${ERROR} $1 failed to install. Please check the $LOG. You may need to install manually."
      exit 1
    fi
  fi
}


ISAUR=$(command -v yay || command -v paru)

# Function for installing packages
install_package() {
  # Checking if package is already installed
  if $ISAUR -Q "$1" &>> /dev/null ; then
    echo -e "${OK} $1 is already installed. Skipping..."
  else
    # Package not installed
    echo -e "${NOTE} Installing $1 ..."
    $ISAUR -S --noconfirm "$1" 
    # Making sure package is installed
    if $ISAUR -Q "$1" &>> /dev/null ; then
      echo -e "\e[1A\e[K${OK} $1 was installed."
    else
      # Something is missing, exiting to review log
      echo -e "\e[1A\e[K${ERROR} $1 failed to install :( , please check the install.log. You may need to install manually! Sorry I have tried :("
      exit 1
    fi
  fi
}

# Function for uninstalling packages
uninstall_package() {
  # Checking if package is installed
  if pacman -Qi "$1" &>> /dev/null ; then
    # Package is installed
    echo -e "${NOTE} Uninstalling $1 ..."
    sudo pacman -Rns --noconfirm "$1" 
    # Making sure package is uninstalled
    if ! pacman -Qi "$1" &>> /dev/null ; then
      echo -e "\e[1A\e[K${OK} $1 was uninstalled."
    else
      # Something went wrong, exiting to review log
      echo -e "\e[1A\e[K${ERROR} $1 failed to uninstall. Please check the log."
      exit 1
    fi
  fi
}
cat <<"EOF"

██████╗  █████╗  ██████╗██╗  ██╗ █████╗  ██████╗ ███████╗███████╗
██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔════╝ ██╔════╝██╔════╝
██████╔╝███████║██║     █████╔╝ ███████║██║  ███╗█████╗  ███████╗
██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══██║██║   ██║██╔══╝  ╚════██║
██║     ██║  ██║╚██████╗██║  ██╗██║  ██║╚██████╔╝███████╗███████║
╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝
                                                                 

EOF

# add packages wanted here
Extra=(
    bitwarden
    bat
    cartridges
    flatpak
    gammastep
    gamemode
    gparted
    heroic-games-launcher-bin
    hyprprop-git
    hyprshade-git
    lutris
    mangal-bin
    man-db
    man-pages
    qview
    scrcpy
    spotify-launcher
    timeshift
    thunar 
    thunar-volman 
    tumbler
    ffmpegthumbnailer
    file-roller 
    thunar-archive-plugin
    vivaldi
    vivaldi-ffmpeg-codecs
    vivaldi-update-ffmpeg-hook
    vivaldi-widevine
    wev
    xwaylandvideobridge
    waypaper
    zathura
    zathura-cb
    zathura-djvu
    zathura-language-server
    zathura-pdf-mupdf
    zathura-ps
    zoxide
)

hypr_package=( 
aylurs-gtk-shell
cliphist
curl 
grim 
gvfs 
gvfs-mtp
hypridle
hyprlock
hyprpaper
imagemagick
inxi 
jq
foot
kvantum
nvim  
network-manager-applet 
pamixer 
pavucontrol
pipewire-alsa 
playerctl
polkit-gnome
python-requests
python-pyquery
pyprland 
qt5ct
qt6ct
qt6-svg
rofi-wayland
slurp 
swappy 
swaync
wallust-git 
waybar
wget
wl-clipboard
wlogout
xdg-user-dirs
xdg-utils 
yad
)

# the following packages can be deleted. however, dotfiles may not work properly
hypr_package_2=(
brightnessctl 
btop
cava
fastfetch
vlc
mpv
mpv-mpris 
nvtop
nwg-look
pacman-contrib
vim
yt-dlp
)

# List of packages to uninstall as it conflicts with swaync or causing swaync to not function properly
uninstall=(
  dunst
  mako
)

# Installation of main components
printf "\n%s - Installing hyprland packages.... \n" "${NOTE}"

for PKG1 in "${hypr_package[@]}" "${hypr_package_2[@]}" "${Extra[@]}"; do
  install_package "$PKG1" 
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG1 Package installation failed, Please check the installation logs"
    exit 1
  fi
done

# Checking if mako or dunst is installed
printf "\n%s - Checking if mako or dunst are installed and removing for swaync to work properly \n" "${NOTE}"
for PKG in "${uninstall[@]}"; do
  uninstall_package "$PKG" 
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG uninstallation failed, please check the log"
    exit 1
  fi
done

clear
sleep 1
cd ~/

cat <<"EOF"

██████╗ ██╗██████╗ ███████╗██╗    ██╗██╗██████╗ ███████╗
██╔══██╗██║██╔══██╗██╔════╝██║    ██║██║██╔══██╗██╔════╝
██████╔╝██║██████╔╝█████╗  ██║ █╗ ██║██║██████╔╝█████╗  
██╔═══╝ ██║██╔═══╝ ██╔══╝  ██║███╗██║██║██╔══██╗██╔══╝  
██║     ██║██║     ███████╗╚███╔███╔╝██║██║  ██║███████╗
╚═╝     ╚═╝╚═╝     ╚══════╝ ╚══╝╚══╝ ╚═╝╚═╝  ╚═╝╚══════╝
                                                        
EOF

###### Install pipewire and pipewire-audio
execute_script "pipewire.sh"

pipewire=(
    pipewire
    wireplumber
    pipewire-audio
    pipewire-alsa
    pipewire-pulse
)

ISAUR=$(command -v yay || command -v paru)

# Removal of pulseaudio
printf "${YELLOW}Removing pulseaudio stuff...${RESET}\n"
for pulseaudio in pulseaudio pulseaudio-alsa pulseaudio-bluetooth; do
    sudo pacman -R --noconfirm "$pulseaudio" 2>/dev/null || true
done

# Disabling pulseaudio to avoid conflicts
systemctl --user disable --now pulseaudio.socket pulseaudio.service 2>/dev/null "

# Pipewire
printf "${NOTE} Installing Pipewire Packages...\n"
for PIPEWIRE in "${pipewire[@]}"; do
    install_package "$PIPEWIRE" "
    [ $? -ne 0 ] && { echo -e "\e[1A\e[K${ERROR} - $PIPEWIRE Package installation failed, Please check the installation logs"; exit 1; }
done

printf "Activating Pipewire Services...\n"
systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service 
systemctl --user enable --now pipewire.service 


clear
sleep
cd ~/

cat <<"EOF"

███████╗ ██████╗ ███╗   ██╗████████╗
██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝
█████╗  ██║   ██║██╔██╗ ██║   ██║   
██╔══╝  ██║   ██║██║╚██╗██║   ██║   
██║     ╚██████╔╝██║ ╚████║   ██║   
╚═╝      ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   
                                    
EOF

fonts=(
adobe-source-code-pro-fonts 
noto-fonts-emoji
otf-font-awesome 
ttf-droid 
ttf-fira-code
ttf-jetbrains-mono 
ttf-jetbrains-mono-nerd 
)

# Installation of main components
printf "\n%s - Installing necessary fonts.... \n" "${NOTE}"

for PKG1 in "${fonts[@]}"; do
  install_package "$PKG1" 
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG1 Package installation failed, Please check the installation logs"
    exit 1
  fi
done

clear
sleep 1
cd ~/

cat <<"EOF"

██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗      █████╗ ███╗   ██╗██████╗ 
██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║     ██╔══██╗████╗  ██║██╔══██╗
███████║ ╚████╔╝ ██████╔╝██████╔╝██║     ███████║██╔██╗ ██║██║  ██║
██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗██║     ██╔══██║██║╚██╗██║██║  ██║
██║  ██║   ██║   ██║     ██║  ██║███████╗██║  ██║██║ ╚████║██████╔╝
╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ 
                                                                   
EOF

hypr=(
hyprland
hyprcursor
xdg-desktop-portal-hyprland
xdg-desktop-portal-gtk
)

# Removing other Hyprland to avoid conflict
printf "${YELLOW} Checking for other hyprland packages and remove if any..${RESET}\n"
if pacman -Qs hyprland > /dev/null; then
  printf "${YELLOW} Hyprland detected. uninstalling to install Hyprland-git...${RESET}\n"
    for hyprnvi in hyprland-git hyprland-nvidia hyprland-nvidia-git hyprland-nvidia-hidpi-git; do
    sudo pacman -R --noconfirm "$hyprnvi" 2>/dev/null 
    done
fi

# Hyprland
printf "${NOTE} Installing Hyprland .......\n"
 for HYPR in "${hypr[@]}"; do
   install_package "$HYPR" 
   [ $? -ne 0 ] && { echo -e "\e[1A\e[K${ERROR} - $HYPR Package installation failed, Please check the installation logs"; exit 1; }
done

clear
sleep 1
cd ~/

cat <<"EOF"

███╗   ██╗██╗   ██╗██╗██████╗ ██╗ █████╗ 
████╗  ██║██║   ██║██║██╔══██╗██║██╔══██╗
██╔██╗ ██║██║   ██║██║██║  ██║██║███████║
██║╚██╗██║╚██╗ ██╔╝██║██║  ██║██║██╔══██║
██║ ╚████║ ╚████╔╝ ██║██████╔╝██║██║  ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═════╝ ╚═╝╚═╝  ╚═╝
                                         
EOF

nvidia_pkg=(
  nvidia-dkms
  nvidia-settings
  nvidia-utils
  libva
  libva-nvidia-driver-git
)

# Install additional Nvidia packages
printf "${YELLOW} Installing addition Nvidia packages...\n"
for krnl in $(cat /usr/lib/modules/*/pkgbase); do
  for NVIDIA in "${krnl}-headers" "${nvidia_pkg[@]}"; do
    install_package "$NVIDIA" 
  done
done

# Check if the Nvidia modules are already added in mkinitcpio.conf and add if not
if grep -qE '^MODULES=.*nvidia. *nvidia_modeset.*nvidia_uvm.*nvidia_drm' /etc/mkinitcpio.conf; then
  echo "Nvidia modules already included in /etc/mkinitcpio.conf" 
else
  sudo sed -Ei 's/^(MODULES=\([^\)]*)\)/\1 nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf 
  echo "Nvidia modules added in /etc/mkinitcpio.conf"
fi

sudo mkinitcpio -P 
printf "\n\n\n"

# Additional Nvidia steps
NVEA="/etc/modprobe.d/nvidia.conf"
if [ -f "$NVEA" ]; then
  printf "${OK} Seems like nvidia-drm modeset=1 is already added in your system..moving on.\n"
  printf "\n"
else
  printf "\n"
  printf "${YELLOW} Adding options to $NVEA..."
  sudo echo -e "options nvidia_drm modeset=1 fbdev=1" | sudo tee -a /etc/modprobe.d/nvidia.conf 
  printf "\n"
fi

# additional for GRUB users
# Check if /etc/default/grub exists
if [ -f /etc/default/grub ]; then
    # Check if nvidia_drm.modeset=1 is already present
    if ! sudo grep -q "nvidia-drm.modeset=1" /etc/default/grub; then
        # Add nvidia_drm.modeset=1 to GRUB_CMDLINE_LINUX_DEFAULT
        sudo sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT=".*\)"/\1 nvidia-drm.modeset=1"/' /etc/default/grub
        # Regenerate GRUB configuration
        sudo grub-mkconfig -o /boot/grub/grub.cfg
        echo "nvidia-drm.modeset=1 added to /etc/default/grub" 
    else
        echo "nvidia-drm.modeset=1 is already present in /etc/default/grub" 
    fi
else
    echo "/etc/default/grub does not exist"
fi

# Blacklist nouveau
    if [[ -z $blacklist_nouveau ]]; then
      read -n1 -rep "${CAT} Would you like to blacklist nouveau? (y/n)" blacklist_nouveau
    fi
echo
if [[ $blacklist_nouveau =~ ^[Yy]$ ]]; then
  NOUVEAU="/etc/modprobe.d/nouveau.conf"
  if [ -f "$NOUVEAU" ]; then
    printf "${OK} Seems like nouveau is already blacklisted..moving on.\n"
  else
    printf "\n"
    echo "blacklist nouveau" | sudo tee -a "$NOUVEAU" 
    printf "${NOTE} has been added to $NOUVEAU.\n"
    printf "\n"

    # To completely blacklist nouveau (See wiki.archlinux.org/title/Kernel_module#Blacklisting 6.1)
    if [ -f "/etc/modprobe.d/blacklist.conf" ]; then
      echo "install nouveau /bin/true" | sudo tee -a "/etc/modprobe.d/blacklist.conf" 
    else
      echo "install nouveau /bin/true" | sudo tee "/etc/modprobe.d/blacklist.conf" 
    fi
  fi
else
  printf "${NOTE} Skipping nouveau blacklisting.\n" 
fi

clear
sleep 1
cd ~/

cat <<"EOF"

██████╗ ██╗     ██╗   ██╗███████╗████████╗ ██████╗  ██████╗ ████████╗██╗  ██╗
██╔══██╗██║     ██║   ██║██╔════╝╚══██╔══╝██╔═══██╗██╔═══██╗╚══██╔══╝██║  ██║
██████╔╝██║     ██║   ██║█████╗     ██║   ██║   ██║██║   ██║   ██║   ███████║
██╔══██╗██║     ██║   ██║██╔══╝     ██║   ██║   ██║██║   ██║   ██║   ██╔══██║
██████╔╝███████╗╚██████╔╝███████╗   ██║   ╚██████╔╝╚██████╔╝   ██║   ██║  ██║
╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝  ╚═════╝    ╚═╝   ╚═╝  ╚═╝
                                                                             
EOF

blue=(
bluez
bluez-utils
blueman
)

# Bluetooth
printf "${NOTE} Installing Bluetooth Packages...\n"
 for BLUE in "${blue[@]}"; do
   install_package "$BLUE"
   [ $? -ne 0 ] && { echo -e "\e[1A\e[K${ERROR} - $BLUE Package installation failed, Please check the installation logs"; exit 1; }
  done

printf " Activating Bluetooth Services...\n"
sudo systemctl enable --now bluetooth.service 2>&1 
clear
sleep 1
cd ~/

cat <<"EOF"

███████╗███████╗██████╗ ███╗   ███╗
██╔════╝██╔════╝██╔══██╗████╗ ████║
███████╗███████╗██║  ██║██╔████╔██║
╚════██║╚════██║██║  ██║██║╚██╔╝██║
███████║███████║██████╔╝██║ ╚═╝ ██║
╚══════╝╚══════╝╚═════╝ ╚═╝     ╚═╝
                                   
EOF

sddm=(
  qt6-5compat 
  qt6-declarative 
  qt6-svg
  sddm
)

# Install SDDM and SDDM theme
printf "${NOTE} Installing sddm and dependencies........\n"
  for package in "${sddm[@]}"; do
  install_package "$package"
  [ $? -ne 0 ] && { echo -e "\e[1A\e[K${ERROR} - $package Package installation failed, Please check the installation logs"; exit 1; }
 done 

# Check if other login managers installed and disabling its service before enabling sddm
for login_manager in lightdm gdm lxdm lxdm-gtk3; do
  if pacman -Qs "$login_manager" > /dev/null; then
    echo "disabling $login_manager..."
    sudo systemctl disable "$login_manager.service"
  fi
done

printf " Activating sddm service........\n"
sudo systemctl enable sddm

# Set up SDDM
echo -e "${NOTE} Setting up the login screen."
sddm_conf_dir=/etc/sddm.conf.d
[ ! -d "$sddm_conf_dir" ] && { printf "$CAT - $sddm_conf_dir not found, creating...\n"; sudo mkdir "$sddm_conf_dir"; }

wayland_sessions_dir=/usr/share/wayland-sessions
[ ! -d "$wayland_sessions_dir" ] && { printf "$CAT - $wayland_sessions_dir not found, creating...\n"; sudo mkdir "$wayland_sessions_dir"; }
sudo cp assets/hyprland.desktop "$wayland_sessions_dir/"
    
# SDDM-themes
valid_input=false
while [ "$valid_input" != true ]; do
    if [[ -z $install_sddm_theme ]]; then
      read -n 1 -r -p "${CAT} OPTIONAL - Would you like to install SDDM themes? (y/n)" install_sddm_theme
    fi
  if [[ $install_sddm_theme =~ ^[Yy]$ ]]; then
    printf "\n%s - Installing SDDM Theme\n" "${NOTE}"

      if [ ! -d "/usr/share/sddm/themes" ]; then
        sudo mkdir -p /usr/share/sddm/themes
        echo -e "\e[1A\e[K${OK} - Directory '/usr/share/sddm/themes' created."
      fi

        git clone https://github.com/stepanzubkov/where-is-my-sddm-theme
        cd where-is-my-sddm-theme
        cp -r where_is_my_sddm_theme/ /usr/share/sddm/themes/
        echo "Successfully installed!"

        if [[ $1 == "current" ]]; then
          sed -i 's/Current=.*/Current=where_is_my_sddm_theme/' /etc/sddm.conf.d/kde_settings.conf
        fi

    else
      echo -e "\e[1A\e[K${ERROR} - Failed to clone the theme repository. Please check your internet connection" | tee -a "$LOG" >&2
    fi
    valid_input=true
  elif [[ $install_sddm_theme =~ ^[Nn]$ ]]; then
    printf "\n%s - No SDDM themes will be installed.\n" "${NOTE}"
    valid_input=true
  else
    printf "\n%s - Invalid input. Please enter 'y' for Yes or 'n' for No.\n" "${ERROR}"
    install_sddm_theme=""
  fi
done

clear
sleep 1
cd ~/

cat <<"EOF"

███████╗███████╗██╗  ██╗
╚══███╔╝██╔════╝██║  ██║
  ███╔╝ ███████╗███████║
 ███╔╝  ╚════██║██╔══██║
███████╗███████║██║  ██║
╚══════╝╚══════╝╚═╝  ╚═╝
                        
EOF

zsh=(
zsh
zsh-completions
fzf
)

# Installing zsh packages
printf "${NOTE} Installing core zsh packages...${RESET}\n"
for ZSH in "${zsh[@]}"; do
  install_package "$ZSH" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
     echo -e "\e[1A\e[K${ERROR} - $ZSH Package installation failed, Please check the installation logs"
  fi
done

# Install Oh My Zsh, plugins, and set zsh as default shell
if command -v zsh >/dev/null; then
  printf "${NOTE} Installing Oh My Zsh and plugins...\n"
	if [ ! -d "$HOME/.oh-my-zsh" ]; then
  		sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
	else
		echo "Directory .oh-my-zsh already exists. Skipping re-installation." 2>&1 | tee -a "$LOG"
	fi
	# Check if the directories exist before cloning the repositories
	if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || true
	else
    	echo "Directory zsh-autosuggestions already exists. Skipping cloning." 2>&1 | tee -a "$LOG"
	fi

	if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || true
	else
    	echo "Directory zsh-syntax-highlighting already exists. Skipping cloning." 2>&1 | tee -a "$LOG"
	fi
	
    printf "${NOTE} Changing default shell to zsh...\n"

	while ! chsh -s $(which zsh); do
    	echo "${ERROR} Authentication failed. Please enter the correct password." 2>&1 | tee -a "$LOG"
    	sleep 1
	done
	printf "${NOTE} Shell changed successfully to zsh.\n" 2>&1 | tee -a "$LOG"

fi

clear
sleep 1
cd ~/

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
cd ~/

### Dotfiles

# عمل نسخة احتياطية لملفاتك الاصلية
mkdir -p ~/config-old
mv ~/.config ~/config-old

sleep 0.5

cd ~/dots
cp -r .config ~/.config
cp -r .icons ~/.icons
cp -r .local ~/.local
cp -r themes ~/.themes
mv /wallpapers ~/Pictures/
cp .zshrc ~/
cp .zprofile ~/

###done 
cat <<"EOF"
██████╗  ██████╗ ███╗   ██╗███████╗
██╔══██╗██╔═══██╗████╗  ██║██╔════╝
██║  ██║██║   ██║██╔██╗ ██║█████╗  
██║  ██║██║   ██║██║╚██╗██║██╔══╝  
██████╔╝╚██████╔╝██║ ╚████║███████╗
╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝
EOF                                   
# echo "Reboot in 10s"
sleep 10 

systemctl reboot