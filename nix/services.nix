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
    resolved.enable = true;

    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    pulseaudio.enable = false;

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

    blueman.enable = true;
    printing = {
      enable = false;
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
  };
}
