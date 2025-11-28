{
config,
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
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    printing = {
      enable = true;
      drivers = [
        pkgs.hplipWithPlugin
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
