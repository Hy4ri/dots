cat <<"EOF"

██████╗ ██╗██████╗ ███████╗██╗    ██╗██╗██████╗ ███████╗
██╔══██╗██║██╔══██╗██╔════╝██║    ██║██║██╔══██╗██╔════╝
██████╔╝██║██████╔╝█████╗  ██║ █╗ ██║██║██████╔╝█████╗  
██╔═══╝ ██║██╔═══╝ ██╔══╝  ██║███╗██║██║██╔══██╗██╔══╝  
██║     ██║██║     ███████╗╚███╔███╔╝██║██║  ██║███████╗
╚═╝     ╚═╝╚═╝     ╚══════╝ ╚══╝╚══╝ ╚═╝╚═╝  ╚═╝╚══════╝
                                                        
EOF

paru -R --noconfirm pulseaudio pulseaudio-alsa pulseaudio-bluetooth

systemctl --user disable --now pulseaudio.socket pulseaudio.service 

paru -S --noconfirm pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse

systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service 
systemctl --user enable --now pipewire.service 


clear
sleep 1
cd ~/dots
