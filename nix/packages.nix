{
  pkgs,
  inputs,
  ...
}: let
  unstable-small = import inputs.nixpkgs-unstable-small {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };

  unstablePackages = with pkgs; [
    alejandra
    android-tools
    antigravity-fhs
    bc
    bemenu
    bitwarden-desktop
    brightnessctl
    btop
    cargo
    clang
    cloudflare-warp
    cmake
    coppwr
    curl
    distrobox
    dua
    dunst
    eza
    fastfetch
    fd
    ffmpeg
    file
    findutils
    frame
    fzf
    gcc
    gdb
    gearlever
    gimp3-with-plugins
    gnumake
    go
    grim
    groff
    heroic
    hyprcursor
    hypridle
    # hyprland-guiutils
    hyprland-qt-support
    hyprlang
    hyprpaper
    hyprpicker
    hyprpolkitagent
    hyprprop
    hyprtoolkit
    hyprutils
    imagemagick
    jdk
    jq
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    kdePackages.qtwayland
    kew
    kitty
    libappindicator
    libnotify
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    lua51Packages.lua
    luarocks
    lutris
    # mangowc
    man-pages
    mpv
    nix-alien
    nixd
    nodejs_24
    nwg-look
    onlyoffice-desktopeditors
    pavucontrol
    php
    playerctl
    # polkit_gnome
    python3
    python313Packages.ds4drv
    python3Packages.pip
    qalculate-gtk
    qbittorrent
    ripgrep
    riseup-vpn
    scrcpy
    slurp
    socat
    spice-gtk
    swappy
    syncthing
    termdown
    trash-cli
    tree-sitter
    ty
    umu-launcher
    unzip
    upower
    upscayl
    usbutils
    vicinae
    waller
    warehouse
    wev
    wf-recorder
    wget
    wine
    wl-clipboard
    wlsunset
    xdg-desktop-portal-hyprland
    xdg-user-dirs
    xdg-utils
    # xwayland-satellite
    yad
    yazi
    yt-dlp
    zathura
    zathuraPkgs.zathura_cb
    zathuraPkgs.zathura_djvu
    zathuraPkgs.zathura_pdf_mupdf
    zathuraPkgs.zathura_djvu
  ];

  # nixos-unstable-small
  unstableSmallPackages = with unstable-small; [
    vesktop
  ];
in {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = unstablePackages ++ unstableSmallPackages;

  #FONTS
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
  };

  programs = {
    dconf.enable = true;
    fuse.userAllowOther = true;
    gamemode.enable = true;
    git.enable = true;
    hyprlock.enable = true;
    niri.enable = false;
    nix-ld.enable = true;
    virt-manager.enable = true;
    waybar.enable = true;
    xwayland.enable = true;

    appimage = {
      enable = true;
      binfmt = true;
    };

    bat = {
      enable = true;
      settings = {
        theme = "TwoDark";
      };
      extraPackages = with pkgs.bat-extras; [
        prettybat
      ];
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    foot = {
      enable = true;
      enableZshIntegration = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    localsend = {
      enable = true;
      openFirewall = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    nh = {
      enable = true;
      flake = "/Documents/Projects/dots/nix/";
    };

    steam = {
      enable = true;
      gamescopeSession.enable = false;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      protontricks.enable = false;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    tmux = {
      enable = true;
      withUtempter = true;
      newSession = true;
      keyMode = "vi";
      historyLimit = 10000;
      baseIndex = 1;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    configPackages = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "com.obsproject.Studio"
  ];
}
