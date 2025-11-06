{
  pkgs,
  inputs,
  ...
}: let
  # Python with required packages
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
      ]
  );
in {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages =
    (with pkgs; [
      # CLI utilities
      bc
      bat
      brightnessctl
      btop
      curl
      dua
      eza
      fastfetch
      findutils
      fzf
      jq
      ripgrep
      termdown
      tmux
      unzip
      wget
      yazi
      yt-dlp
      zoxide

      # Development tools
      cargo
      clang
      cmake
      gcc
      gdb
      go
      gnumake
      nodejs_24

      # Media tools
      ffmpeg
      grim
      imagemagick
      mpv
      nsxiv
      scrcpy
      slurp
      swappy
      swww
      wf-recorder

      # Desktop applications
      bitwarden-desktop
      blueman
      cloudflare-warp
      cliphist
      dunst
      foot
      gimp3-with-plugins
      heroic
      kitty
      localsend
      lutris
      neovide
      normcap
      nwg-look
      pavucontrol
      polkit_gnome
      qalculate-gtk
      rofi
      syncthing
      vivaldi
      vivaldi-ffmpeg-codecs
      wine
      zathura

      # Hyprland ecosystem
      hypridle
      hyprcursor
      hyprutils
      hyprpicker
      hyprprop
      hyprpolkitagent
      hyprsunset
      hyprland-qt-support

      # Qt/KDE packages
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum
      kdePackages.kdeconnect-kde
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct

      # System libraries
      libappindicator
      libnotify

      # Documentation
      man-db
      man-pages

      # Gaming and multimedia
      python313Packages.ds4drv
      playerctl
      power-profiles-daemon

      # XDG and Wayland
      wl-clipboard
      wev
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gnome
      xdg-user-dirs
      xdg-utils
      xwayland-satellite

      # Utilities
      yad
      riseup-vpn
    ])
    ++ [
      python-packages
    ];

  # Font configuration
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.victor-mono
    ];
  };

  # Program configuration
  programs = {
    # AppImage support
    appimage.enable = true;
    appimage.binfmt = true;
    
    # Gaming
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = false;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      protontricks.enable = false;
    };
    
    # MangoHud overlay
    mango.enable = true;
    
    # Shell and terminal
    zsh.enable = true;
    
    # Desktop environment
    waybar.enable = true;
    niri.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    hyprlock.enable = true;
    uwsm.enable = true;
    hyprland.withUWSM = true;
    xwayland.enable = true;
    dconf.enable = true;
    fuse.userAllowOther = true;

    # Browsers
    firefox.enable = true;
    
    # Virtualization
    virt-manager.enable = true;

    # Editor
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    # Nix helper
    nh = {
      enable = true;
      flake = "/home/m57/dots/nix";
    };

    # Security
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    
    # Git configuration
    git = {
      enable = true;
      config = {
        user.name = "hy4ri";
        user.email = "hiari45@gmail.com";
        init.defaultBranch = "main";
      };
    };
  };

  # XDG portal configuration
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };

  # Flatpak applications
  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "io.github.flattool.Warehouse"
    "it.mijorus.gearlever"
    "com.obsproject.Studio"
    "org.telegram.desktop"
    "it.mijorus.smile"
    "org.equicord.equibop"
  ];
}
