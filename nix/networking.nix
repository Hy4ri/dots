{...}: {
  networking = {
    hostName = "hyari";
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
