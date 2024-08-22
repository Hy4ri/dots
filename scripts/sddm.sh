cat <<"EOF"

███████╗███████╗██████╗ ███╗   ███╗
██╔════╝██╔════╝██╔══██╗████╗ ████║
███████╗███████╗██║  ██║██╔████╔██║
╚════██║╚════██║██║  ██║██║╚██╔╝██║
███████║███████║██████╔╝██║ ╚═╝ ██║
╚══════╝╚══════╝╚═════╝ ╚═╝     ╚═╝

EOF

paru -Sy --noconfirm --needed sddm

git clone https://github.com/stepanzubkov/where-is-my-sddm-theme
cd where-is-my-sddm-theme
sudo ./install current

systemctl enable sddm.service

clear
sleep 1
cd ~/m57-dots-install
