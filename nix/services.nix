{
pkgs,
...
}: {
  services = {
    power-profiles-daemon.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;
    pulseaudio.enable = false;
    blueman.enable = true;

    displayManager = {
      enable = true;
      ly = {
        enable = true;
        x11Support = false;
      };
    };
    resolved = {
      enable = true;
      extraConfig = ''
        [Resolve]
        ResolveUnicastSingleLabel=yes
      '';
    };

    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
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

    fstrim = {
      enable = true;
      interval = "daily";
    };

    printing = {
      enable = true;
      startWhenNeeded = true;
      drivers = with pkgs; [
        hplipWithPlugin
      ];
    };

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

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
