cat <<"EOF"


██╗   ██╗ █████╗ ██╗   ██╗
╚██╗ ██╔╝██╔══██╗╚██╗ ██╔╝
 ╚████╔╝ ███████║ ╚████╔╝ 
  ╚██╔╝  ██╔══██║  ╚██╔╝  
   ██║   ██║  ██║   ██║   
   ╚═╝   ╚═╝  ╚═╝   ╚═╝   
                                 
EOF

cd ~/

check_paru_installed() {
    if command -v yay &> /dev/null
    then
        yay -Syu --noconfirm
    else
        pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        yay -Syu --noconfirm
    fi
}
check_paru_installed

sleep 1
cd ~/dots

