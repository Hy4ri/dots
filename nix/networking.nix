{
  lib,
  config,
  pkgs,
  ...
}: {
  networking = {
    # Hostname
    hostName = "hyari";
    
    # Network management
    networkmanager = {
      enable = true;
    };
    
    # DNS nameservers (Cloudflare)
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
  };
}
