{
pkgs,
...
}: {
  services = {
    blueman.enable = true;
    dbus.enable = true;
    envfs.enable = true;
    gvfs.enable = true;
    power-profiles-daemon.enable = true;
    pulseaudio.enable = false;
    tumbler.enable = true;
    udisks2.enable = true;

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
      overrides = {
        global = {
          Context.sockets = ["wayland" "!x11" "!fallback-x11"];
          Environment = {
            GTK_THEME = "theme";
          };
        };
      };
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
  };
}
