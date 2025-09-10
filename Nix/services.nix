{
  config,
  pkgs,
  ...
}: {
  services = {
    flatpak.enable = true;
    power-profiles-daemon.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;

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
      enable = true;
      drivers = [
        pkgs.hplipWithPlugin
      ];
    };
  };

  systemd.services.flatpak-repo = {
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
