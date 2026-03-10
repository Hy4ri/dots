{...}: {
  networking = {
    hostName = "hyari";
    networkmanager = {
      enable = true;
    };
    nameservers = [
    ];
    firewall = {
      enable = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
