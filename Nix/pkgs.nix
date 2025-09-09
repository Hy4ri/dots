{
  pkgs,
  inputs,
  ...
}: let
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
      ]
  );
in {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      alacritty
      bc
      bat
      brightnessctl
      btop
      binutils
      blueman
      cliphist
      curl
      clang
      cargo
      dua
      duf
      dunst
      python313Packages.ds4drv
      emote
      eza
      equibop
      fastfetch
      file-roller
      findutils
      ffmpeg
      foot
      fzf
      gamemode
      gcc
      gdb
      gimp3-with-plugins
      go
      grim
      gnumake
      heroic
      hyprcursor
      hypridle
      hyprlock
      hyprland
      hyprutils
      hyprpicker
      hyprprop
      hyprpolkitagent
      hyprsunset
      hyprland-qt-support
      imagemagick
      inxi
      jq
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum
      kitty
      killall
      lutris
      localsend
      libappindicator
      libnotify
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      man-db
      man-pages
      mpv
      nixd
      nemo-with-extensions
      nemo-fileroller
      networkmanagerapplet
      nvtopPackages.full
      normcap
      neovide
      nodejs_24
      nsxiv
      nwg-look
      openrgb
      pamixer
      pavucontrol
      playerctl
      power-profiles-daemon
      qalculate-gtk
      rofi-wayland
      ripgrep
      scrcpy
      slurp
      spicetify-cli
      swappy
      swww
      termdown
      tesseract4
      # upscyal
      unzip
      uwsm
      vivaldi
      vivaldi-ffmpeg-codecs
      vlc
      waybar
      waypaper
      wget
      wl-clipboard
      wev
      xdg-desktop-portal-hyprland
      xdg-user-dirs
      xdg-utils
      yad
      yt-dlp
      zathura
      zoxide
    ])
    ++ [
      python-packages
    ];

  #FONTS
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };

  programs = {
    hyprland = {
      enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    appimage.enable = true;
    appimage.binfmt = true;
    gamemode.enable = true;
    zsh.enable = true;
    waybar.enable = true;
    hyprlock.enable = true;
    firefox.enable = true;
    nm-applet.indicator = true;
    virt-manager.enable = false;

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    nh = {
      enable = true;
      flake = "~/Documents/Projects/dots/Nix/"; # sets NH_OS_FLAKE variable for you
    };

    steam = {
      enable = true;
      gamescopeSession.enable = false;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
    };

    xwayland.enable = true;

    dconf.enable = true;
    fuse.userAllowOther = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    git = {
      enable = true;
      config = {
        user.Name = "hy4ri";
        user.Email = "hiari45@gmail.com";
        init.defaultBranch = "main";
      };
    };
  };
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
}
