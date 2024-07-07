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
cd where-is-my-sddm-theme
sudo ./install

systemctl enable sddm.service --now

clear
sleep 1
cd ~/dots