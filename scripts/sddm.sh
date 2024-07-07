cat <<"EOF"

███████╗███████╗██████╗ ███╗   ███╗
██╔════╝██╔════╝██╔══██╗████╗ ████║
███████╗███████╗██║  ██║██╔████╔██║
╚════██║╚════██║██║  ██║██║╚██╔╝██║
███████║███████║██████╔╝██║ ╚═╝ ██║
╚══════╝╚══════╝╚═════╝ ╚═╝     ╚═╝
                                   
EOF

paru -S --noconfirm sddm qt6-5compat qt6-declarative qt6-svgsddm

git clone https://github.com/stepanzubkov/where-is-my-sddm-theme
cd where_is_my_sddm_theme
sudo cp -r ~/dots/where_is_my_sddm_theme/ /usr/share/sddm/themes/
echo "Successfully installed"
if [[ $1 == "current" ]]; then
  sed -i 's/Current=.*/Current=where_is_my_sddm_theme/' /etc/sddm.conf.d/kde_settings.conf
fi

systemctl enable sddm.service --now

clear
sleep 1
cd ~/dots