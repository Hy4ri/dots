{
  config,
  pkgs,
  ...
}: {
  # Import hardware and service configurations
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./nvidia.nix
    ./intel.nix
    ./prime.nix
    ./pkgs.nix
    ./services.nix
  ];
 
  # Boot configuration
  boot = {
    loader = {
      timeout = 5; 
      systemd-boot.enable = true;
      efi = { 
        canTouchEfiVariables = true;
      };
    };
    
    # Use latest kernel packages
    kernelPackages = pkgs.linuxPackages_latest;
    
    # Kernel parameters for optimization and compatibility
    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device"
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco"
      "modprobe.blacklist=iTCO_wdt"
    ];
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];

    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = [];
    };

    # System control settings
    kernel = {
      sysctl = {
        "vm.max_map_count" = 2147483642;
      };
    };

  # AppImage support
  binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };
  };

  # Graphics drivers configuration
  drivers = {
    intel.enable = true;
    nvidia.enable = true;
    nvidia-prime = {
      enable = true;
      intelBusID = "PCI:0:2:0";
      nvidiaBusID = "PCI:1:0:0";
    };
  };

  # System locale and timezone
  time.timeZone = "Asia/Amman";

  # Internationalization
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

  # Security settings
  security.rtkit.enable = true;

  # User configuration
  users.users.m57 = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "hyari";
    extraGroups = ["input" "networkmanager" "wheel" "scanner" "lp" "video" "audio"];
  };

  # Hardware configuration
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
    graphics = {
      enable = true;
    };
  };

  # Nix package manager settings
  nix = {
    settings = {
      auto-optimise-store = true;
      download-buffer-size = 104857600;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ 
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
  };

  # Virtualization
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
