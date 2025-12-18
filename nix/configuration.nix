{
pkgs,
...
}: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./graphics.nix
    ./packages.nix
    ./services.nix
    ./mimeapps.nix
    ./theme.nix
  ];

  boot = {
    tmp.cleanOnBoot = true;
    tmp.useTmpfs = true;
    loader = {
      timeout = 5; 
      systemd-boot.enable = true;
      efi = { 
        canTouchEfiVariables = true;
      };
    };
    kernelPackages = pkgs.linuxPackages_zen;
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco"
      "modprobe.blacklist=iTCO_wdt"
      "usbcore.autosuspend=-1"
    ];
    kernelModules = ["kvm-intel"];

    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.max_map_count" = 16777216;
      "vm.dirty_bytes" = 268435456;
      "vm.dirty_background_bytes" = 67108864;
      "vm.dirty_writeback_centisecs" = 1500;
      "kernel.printk" = "3 3 3 3";
      "kernel.kptr_restrict" = 2;
      "kernel.kexec_load_disabled" = 1;
    };

    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
    };
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };

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
      dates = [ "weekly" ];
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
      enable = false;
      dockerCompat = false;
      defaultNetwork.settings.dns_enabled = false;
    };
  };

  system.stateVersion = "25.05";
}
