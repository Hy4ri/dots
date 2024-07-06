cat <<"EOF"

██████╗  █████╗ ██████╗ ██╗   ██╗
██╔══██╗██╔══██╗██╔══██╗██║   ██║
██████╔╝███████║██████╔╝██║   ██║
██╔═══╝ ██╔══██║██╔══██╗██║   ██║
██║     ██║  ██║██║  ██║╚██████╔╝
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ 
                                 
EOF

cd ~/

check_paru_installed() {
    if command -v paru &> /dev/null
    then
        paru -Syu --noconfirm
    else
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si --noconfirm
        sleep 1
        paru -Syu --noconfirm
    fi
}
check_paru_installed

clear
sleep 1
cd ~/dots