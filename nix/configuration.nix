{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./boot.nix
    ./graphics.nix
    ./packages.nix
    ./services.nix
    ./mimeapps.nix
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
    extraGroups = ["input" "networkmanager" "wheel" "scanner" "lp" "video" "audio" "libvirt" "kvm"];
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      max-jobs = "auto";
      cores = 0;
      sandbox = true;
      download-buffer-size = 104857600;
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://hyprland.cachix.org"
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://chaotic-nyx.cachix.org/"
        "https://ezkea.cachix.org"
        "https://install.determinate.systems"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
        "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
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
      generateCaches = false;
    };
    nixos.enable = false;
  };

  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = false;
    };
  };

  system.stateVersion = "25.05";
}
