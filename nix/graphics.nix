{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfgNvidia = config.drivers.nvidia;
  cfgIntel = config.drivers.intel;
  cfgPrime = config.drivers.nvidia-prime;
in {
  options.drivers = {
    nvidia = {
      enable = mkEnableOption "Enable Nvidia Drivers";
    };

    intel = {
      enable = mkEnableOption "Enable Intel Graphics Drivers";
    };

    nvidia-prime = {
      enable = mkEnableOption "Enable Nvidia Prime Hybrid GPU Offload";
      intelBusID = mkOption {
        type = types.str;
        default = "PCI:0:2:0";
        description = "Bus ID of the Intel GPU";
      };
      nvidiaBusID = mkOption {
        type = types.str;
        default = "PCI:1:0:0";
        description = "Bus ID of the Nvidia GPU";
      };
    };
  };

  config = mkMerge [
    # ---------------------------------------------------------
    # Nvidia Configuration
    # ---------------------------------------------------------
    (mkIf cfgNvidia.enable {
      services.xserver.videoDrivers = ["nvidia"];

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          mesa
          libva-vdpau-driver
          libvdpau
          libvdpau-va-gl
          nvidia-vaapi-driver
          vdpauinfo
          libva
          libva-utils
        ];
      };

      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        dynamicBoost.enable = false;
        nvidiaPersistenced = false;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
    })

    # ---------------------------------------------------------
    # Intel Configuration
    # ---------------------------------------------------------
    (mkIf cfgIntel.enable {
      nixpkgs.config.packageOverrides = pkgs: {
        vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
      };

      # OpenGL / Hardware Graphics
      hardware.graphics = {
        extraPackages = with pkgs; [
          intel-media-driver
          libvdpau-va-gl
          libva
          libva-utils
        ];
      };
    })

    # ---------------------------------------------------------
    # Nvidia Prime (Hybrid) Configuration
    # ---------------------------------------------------------
    (mkIf cfgPrime.enable {
      hardware.nvidia = {
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
          intelBusId = cfgPrime.intelBusID;
          nvidiaBusId = cfgPrime.nvidiaBusID;
        };
      };
    })
  ];
}
