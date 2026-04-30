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
    eza
    fd
    ffmpeg
    file
    findutils
    fish
    foot
    frame
    fzf
    gcc
    gdb
    gemini-cli
    gh
    ghostty
    gifski
    gimp3
    gnumake
    go
    grim
    groff
    hyprcursor
    hyprland-qt-support
    hyprlang
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
    man-pages
    mpv
    nix-alien
    nixd
    nodejs_25
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
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
    translate-shell
    (tesseract.override {
      enableLanguages = ["eng" "ara"];
    })
    umu-launcher
    unzip
    usbutils
    vesktop
    vivaldi-snapshot
    warehouse
    wev
    wget
    wine
    wl-clipboard
    wl-screenrec
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
    zbar
  ];

  # nixos-unstable-small
  unstableSmallPackages = with unstable-small; [
    antigravity-fhs
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
      flake = "$HOME/Projects/dots/nix/";
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
}
