cat <<"EOF"

██████╗  █████╗  ██████╗██╗  ██╗ █████╗  ██████╗ ███████╗███████╗
██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔════╝ ██╔════╝██╔════╝
██████╔╝███████║██║     █████╔╝ ███████║██║  ███╗█████╗  ███████╗
██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══██║██║   ██║██╔══╝  ╚════██║
██║     ██║  ██║╚██████╗██║  ██╗██║  ██║╚██████╔╝███████╗███████║
╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝


EOF

cd ~/

paru -Sy --noconfirm --needed bitwarden bat cartridges flatpak gammastep gamemode gparted heroic-games-launcher-bin hyprprop-git hyprshade-git lutris mangal-bin man-db man-pages openrgb papirus-folders-git papirus-icon-theme power-profiles-daemon qview scrcpy spotify-launcher spicetify-cli timeshift thunar thunar-volman tumbler ffmpegthumbnailer file-roller thunar-archive-plugin vivaldi vivaldi-ffmpeg-codecs vivaldi-update-ffmpeg-hook vivaldi-widevine vesktop wev xwaylandvideobridge waypaper zathura zathura-cb zathura-djvu zathura-language-server zathura-pdf-mupdf zathura-ps zoxide

sleep 2

paru -Sy --noconfirm --needed aylurs-gtk-shell cliphist curl grim gvfs gvfs-mtp hypridle hyprlock hyprpaper imagemagick inxi jq foot kvantum nvim network-manager-applet pamixer pavucontrol pipewire-alsa playerctl polkit-gnome python-requests python-pyquery pyprland qt5ct qt6ct qt6-svg rofi-wayland slurp swappy swaync wallust-git waybar wget wl-clipboard wlogout xdg-user-dirs xdg-utils yad

sleep 2

paru -Sy --noconfirm --needed brightnessctl btop cava eza fastfetch vlc mpv mpv-mpris nvtop nwg-look pacman-contrib vim yt-dlp wlogout

sleep 2

paru -Sy --noconfirm --needed ds4drv game-devices-udev dualsensectl xone-dkms

sleep 2

paru -R --noconfirm dunst mako

sudo curl -sL github.com/justchokingaround/jerry/raw/main/jerry.sh -o /usr/local/bin/jerry &&
sudo chmod +x /usr/local/bin/jerry

clear
sleep 1
cd ~/dots
