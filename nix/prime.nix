{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.drivers.nvidia-prime;
in {
  options.drivers.nvidia-prime = {
    enable = mkEnableOption "Enable Nvidia Prime Hybrid GPU Offload";
    intelBusID = mkOption {
      type = types.str;
      default = "PCI:0:2:0";
      description = "PCI Bus ID for Intel GPU";
    };
    nvidiaBusID = mkOption {
      type = types.str;
      default = "PCI:1:0:0";
      description = "PCI Bus ID for Nvidia GPU";
    };
  };

  config = mkIf cfg.enable {
    # Nvidia Prime configuration for hybrid graphics
    hardware.nvidia = {
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        # Make sure to use the correct Bus ID values for your system!
        intelBusId = "${cfg.intelBusID}";
        nvidiaBusId = "${cfg.nvidiaBusID}";
      };
    };
  };
}
