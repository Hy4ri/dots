cat <<"EOF"

███████╗███████╗██████╗ ███╗   ███╗
██╔════╝██╔════╝██╔══██╗████╗ ████║
███████╗███████╗██║  ██║██╔████╔██║
╚════██║╚════██║██║  ██║██║╚██╔╝██║
███████║███████║██████╔╝██║ ╚═╝ ██║
╚══════╝╚══════╝╚═════╝ ╚═╝     ╚═╝
                                   
EOF

paru -S --noconfirm qt6-5compat qt6-declarative qt6-svgsddm


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
cd ~/dots