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
      bat
      brightnessctl
      btop
      bitwarden
      blueman
      cloudflare-warp
      cliphist
      curl
      cargo
      clang
      cmake
      dua
      dunst
      python313Packages.ds4drv
      eza
      equibop
      fastfetch
      file-roller
      findutils
      ffmpeg
      foot
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
      hyprsunset
      hyprland-qt-support
      imagemagick
      jq
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum
      kitty
      lutris
      localsend
      libappindicator
      libnotify
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      man-db
      man-pages
      mpv
      nemo-with-extensions
      nemo-fileroller
      normcap
      neovide
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
      scrcpy
      slurp
      swappy
      swww
      termdown
      tmux
      unzip
      vivaldi
      vivaldi-ffmpeg-codecs
      wf-recorder
      wget
      wl-clipboard
      wev
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gnome
      xdg-user-dirs
      xdg-utils
      xwayland-satellite
      yad
      yazi
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
    appimage.enable = true;
    appimage.binfmt = true;
    gamemode.enable = false;
    zsh.enable = true;
    waybar.enable = true;
    firefox.enable = true;
    virt-manager.enable = true;
    hyprlock.enable = true;
    hyprland.withUWSM = true;
    uwsm.enable = true;
    xwayland.enable = true;
    dconf.enable = true;
    fuse.userAllowOther = true;

    niri.enable = true;

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    nh = {
      enable = true;
      flake = "~/Documents/Projects/dots/Nix/";
    };

    steam = {
      enable = true;
      gamescopeSession.enable = false;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      protontricks.enable = false;
    };

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

  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "io.github.flattool.Warehouse"
    "it.mijorus.gearlever"
    "com.obsproject.Studio"
    "org.telegram.desktop"
    "it.mijorus.smile"
  ];
}
