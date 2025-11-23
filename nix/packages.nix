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
      antigravity
      bc
      brightnessctl
      btop
      bitwarden-desktop
      blueman
      cloudflare-warp
      curl
      cargo
      clang
      cmake
      dua
      dunst
      eza
      fastfetch
      findutils
      ffmpeg
      fzf
      gcc
      gdb
      gimp3-with-plugins
      go
      grim
      gnumake
      gearlever
      heroic
      hypridle
      hyprcursor
      hyprutils
      hyprpicker
      hyprprop
      hyprpolkitagent
      hyprland-qt-support
      hyprland-qtutils
      # hyprland-guiutils
      hyprwire
      hyprpwcenter
      hyprtoolkit
      imagemagick
      jdk
      jq
      julia
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum
      kitty
      lutris
      lua51Packages.lua
      luarocks
      libappindicator
      libnotify
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      man-db
      man-pages
      mpv
      nodejs_24
      nwg-look
      oculante
      pavucontrol
      playerctl
      php
      python313Packages.ds4drv
      python3Packages.pip
      power-profiles-daemon
      polkit_gnome
      qalculate-gtk
      qbittorrent
      rofi
      ripgrep
      riseup-vpn
      scrcpy
      slurp
      socat
      spice-gtk
      swappy
      swww
      syncthing
      termdown
      trash-cli
      tree-sitter
      fd
      unzip
      upower
      upower-notify
      usbutils
      vicinae
      wf-recorder
      wget
      wl-clipboard
      wlsunset
      warehouse
      wev
      wine
      xdg-desktop-portal-hyprland
      xdg-user-dirs
      xdg-utils
      xwayland-satellite
      yad
      yazi
      yt-dlp
      zathura
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
    adb.enable = true;
    appimage.enable = true;
    appimage.binfmt = true;
    gamemode.enable = true;
    waybar.enable = true;
    virt-manager.enable = true;
    hyprlock.enable = true;
    uwsm.enable = true;
    xwayland.enable = true;
    dconf.enable = true;
    fuse.userAllowOther = true;
    mango.enable = true;
    niri.enable = true;

    bat = {
      enable = true;
      settings = {
        theme = "TwoDark";
      };
      extraPackages = 
        with pkgs.bat-extras; [
          prettybat
        ];
    };

    foot = {
      enable = true;
      enableZshIntegration = true;
    };

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
      withUWSM = true;
    };

    localsend = {
      enable = true;
      openFirewall = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
    };

    tmux = {
      enable = true;
      withUtempter = true;
      newSession = true;
      keyMode = "vi";
      historyLimit = 10000;
      baseIndex = 1;
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
      extraCompatPackages = 
        with pkgs; [
          proton-ge-bin
        ];
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    git = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
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

  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "com.obsproject.Studio"
    "org.equicord.equibop"
  ];
}
