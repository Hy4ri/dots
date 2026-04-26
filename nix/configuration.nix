{pkgs, ...}: {
  imports = [
    ./boot.nix
    ./graphics.nix
    ./hardware.nix
    ./mimeapps.nix
    ./networking.nix
    ./programs.nix
    ./services.nix
    ./theme.nix
  ];

  drivers = {
    intel.enable = true;
    nvidia.enable = true;
    nvidia-prime = {
      enable = true;
      intelBusID = "PCI:0:2:0";
      nvidiaBusID = "PCI:1:0:0";
    };
  };

  time.timeZone = "Asia/Amman";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  security.rtkit.enable = true;

  users.users.m57 = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "hyari";
    extraGroups = ["input" "networkmanager" "wheel" "scanner" "lp" "video" "audio" "kvm"];
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      cores = 0;
      download-buffer-size = 104857600;
      max-jobs = "auto";
      sandbox = true;
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://hyprland.cachix.org"
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://install.determinate.systems"
        "https://noctalia.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };
    gc = {
      automatic = false;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
  };

  documentation = {
    enable = true;
    man = {
      enable = true;
      cache = {
        generateAtRuntime = false;
        enable = false;
      };
    };
    nixos.enable = false;
  };

  virtualisation = {
    libvirtd.enable = false;
    podman = {
      enable = false;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = false;
    };
  };

  system.stateVersion = "25.05";
}
