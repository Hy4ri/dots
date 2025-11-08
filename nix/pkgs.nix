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
      python313Packages.ds4drv
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
      heroic
      hypridle
      hyprcursor
      hyprutils
      hyprpicker
      hyprprop
      hyprpolkitagent
      hyprland-qt-support
      imagemagick
      jq
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum
      kitty
      lutris
      libappindicator
      libnotify
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      man-db
      man-pages
      mpv
      nodejs_24
      nsxiv
      nwg-look
      pavucontrol
      playerctl
      power-profiles-daemon
      polkit_gnome
      qalculate-gtk
      rofi
      ripgrep
      riseup-vpn
      scrcpy
      slurp
      swappy
      swww
      syncthing
      termdown
      unzip
      vicinae
      vivaldi
      vivaldi-ffmpeg-codecs
      wf-recorder
      wget
      wl-clipboard
      wlsunset
      wev
      wine
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gnome
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
      nerd-fonts.victor-mono
    ];
  };

  programs = {
    adb.enable = true;
    appimage.enable = true;
    appimage.binfmt = true;
    gamemode.enable = true;
    zsh.enable = true;
    waybar.enable = true;
    firefox.enable = true;
    virt-manager.enable = true;
    hyprlock.enable = true;
    uwsm.enable = true;
    xwayland.enable = true;
    dconf.enable = true;
    fuse.userAllowOther = true;
    # mango.enable = true;
    niri.enable = true;
    kdeconnect.enable = true;

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
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
      shortcut = " ";
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
      config = {
        user.name = "hy4ri";
        user.email = "hiari45@gmail.com";
        init.defaultBranch = "main";
      };
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
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
    "io.github.flattool.Warehouse"
    "it.mijorus.gearlever"
    "com.obsproject.Studio"
    "org.telegram.desktop"
    "org.equicord.equibop"
  ];
}
