{
pkgs,
inputs,
...
}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      antigravity-fhs
      bc
      bitwarden-desktop
      brightnessctl
      btop
      cargo
      clang
      cloudflare-warp
      cmake
      coppwr
      curl
      dua
      dunst
      eza
      fastfetch
      fd
      ffmpeg
      findutils
      fzf
      gcc
      gdb
      gearlever
      ghostty
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
      hyprland-qtutils
      hyprpicker
      hyprpolkitagent
      hyprprop
      hyprtoolkit
      hyprutils
      imagemagick
      jdk
      jq
      julia
      kdePackages.qt6ct
      kdePackages.qtstyleplugin-kvantum
      kdePackages.qtwayland
      kew
      libappindicator
      libnotify
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      lua51Packages.lua
      luarocks
      lutris
      man-pages
      # mangowc
      mpv
      nixd
      nodejs_24
      nwg-look
      oculante
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
      rofi
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
      unzip
      upower
      upower-notify
      usbutils
      umu-launcher
      vicinae
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
    ]);

  #FONTS
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
    fuse.userAllowOther = true;
    gamemode.enable = true;
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
      extraPackages = 
        with pkgs.bat-extras; [
          prettybat
        ];
    };

    foot = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
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
    "org.equicord.equibop"
  ];
}
