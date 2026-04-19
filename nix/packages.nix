{
  pkgs,
  inputs,
  ...
}: let
  unstable-small = import inputs.nixpkgs-unstable-small {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };

  stable = import inputs.nixpkgs-stable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };

  unstablePackages = with pkgs; [
    alejandra
    android-tools
    bc
    bemenu
    brightnessctl
    btop
    cargo
    clang
    cmake
    curl
    dua
    dunst
    emacs-pgtk
    eza
    fastfetch
    fd
    ffmpeg
    file
    findutils
    foot
    frame
    fzf
    gcc
    gdb
    ghostty
    gimp3-with-plugins
    gnumake
    go
    grim
    groff
    hyprcursor
    hypridle
    hyprland-qt-support
    hyprlang
    hyprpicker
    hyprpolkitagent
    hyprtoolkit
    hyprutils
    imagemagick
    jq
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    kdePackages.qtwayland
    libappindicator
    libnotify
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    lua51Packages.lua
    luarocks
    lutris
    man-pages
    mpv
    nix-alien
    nixd
    nodejs_25
    nwg-look
    opencode
    pavucontrol
    playerctl
    python3
    python3Packages.pip
    qalculate-gtk
    ripgrep
    scrcpy
    slurp
    socat
    swappy
    termdown
    tree-sitter
    umu-launcher
    unzip
    usbutils
    vivaldi-stable
    warehouse
    wev
    wget
    wine
    wl-clipboard
    xdg-desktop-portal-hyprland
    xdg-user-dirs
    xdg-utils
    yad
    yazi
    yt-dlp
    zathura
    zathuraPkgs.zathura_cb
    zathuraPkgs.zathura_djvu
    zathuraPkgs.zathura_pdf_mupdf
  ];

  # nixos-unstable-small
  unstableSmallPackages = with unstable-small; [
    antigravity-fhs
    vesktop
  ];

  # nixos-stable
  stablePackages = with stable; [
    bitwarden-desktop
    heroic
  ];
in {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = unstablePackages ++ unstableSmallPackages ++ stablePackages;

  #FONTS
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      emacs-all-the-icons-fonts
    ];
  };

  programs = {
    dconf.enable = true;
    fuse.userAllowOther = true;
    gamemode.enable = true;
    git.enable = true;
    nano.enable = false;
    niri.enable = false;
    nix-ld.enable = true;
    virt-manager.enable = false;
    waybar.enable = false;
    xwayland.enable = true;

    appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override {
        extraPkgs = pkgs: [pkgs.zstd];
      };
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

    dms-shell = {
      enable = true;
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
      quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;

      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableVPN = false; # VPN management widget
      enableDynamicTheming = true; # Wallpaper-based theming (matugen)
      enableAudioWavelength = false; # Audio visualizer (cava)
      enableCalendarEvents = true; # Calendar integration (khal)
      enableClipboardPaste = true; # Pasting from the clipboard history (wtype)
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    hyprland = {
      enable = true;
      # package = unstable-small.hyprland;
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
    };

    nh = {
      enable = true;
      flake = "$HOME/Documents/Projects/dots/nix/";
    };

    steam = {
      enable = true;
    };

    tmux = {
      enable = true;
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
