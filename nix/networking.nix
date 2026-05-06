{...}: {
  networking = {
    hostName = "hyari";
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [22 80 443 4096];
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
