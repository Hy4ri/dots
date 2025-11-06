{
  config,
  pkgs,
  ...
}: {
  services = {
    # Power management
    power-profiles-daemon.enable = true;
    
    # Storage and filesystem
    udisks2.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    fstrim = {
      enable = true;
      interval = "weekly";
    };

    # System services
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;
    
    # Audio
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    # DNS resolver
    resolved = {
      enable = true;
      extraConfig = ''
        [Resolve]
        ResolveUnicastSingleLabel=yes
        '';
    };

    # Display server (disabled, using Wayland)
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    # Bluetooth
    blueman.enable = true;
    
    # Printing
    printing = {
      enable = false;
      drivers = [
        pkgs.hplipWithPlugin
      ];
    };

    # Flatpak configuration
    flatpak = {
      enable = true;
      overrides = {
        global = {
          Context.sockets = ["wayland" "!x11" "!fallback-x11"];
          Environment = {
            GTK_THEME = "theme";
          };
        };
      };
    };
  };
}
