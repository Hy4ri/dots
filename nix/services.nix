{pkgs, ...}: {
  services = {
    blueman.enable = true;
    dbus.enable = true;
    envfs.enable = true;
    gvfs.enable = false;
    power-profiles-daemon.enable = true;
    pulseaudio.enable = false;
    speechd.enable = false;
    tumbler.enable = true;
    udisks2.enable = true;
    upower.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    displayManager = {
      enable = false;
      ly = {
        enable = false;
        x11Support = false;
      };
    };

    flatpak = {
      enable = true;
    };

    fstrim = {
      enable = true;
      interval = "daily";
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    printing = {
      enable = true;
      startWhenNeeded = true;
      drivers = with pkgs; [
        hplipWithPlugin
      ];
    };

    resolved = {
      enable = false;
      settings.Resolve = {
        ResolveUnicastSingleLabel = true;
      };
    };

    tailscale = {
      enable = true;
    };

    udev = {
      packages = with pkgs; [
        game-devices-udev-rules
      ];
    };

    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };
}
