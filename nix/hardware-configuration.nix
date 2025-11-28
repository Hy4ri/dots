{
config,
lib,
modulesPath,
...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/bb2eefc1-9d8c-43a7-a6eb-1da5a7407348";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9230-1FCA";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/ff5c64e0-a7dd-4550-b785-8c434dde63f9";
    fsType = "ext4";
    options = [
      "defaults"
      "noatime"
    ];
  };

  fileSystems."/run/media/m57/SSD-Linux" = {
    device = "/dev/disk/by-uuid/8cfeb7a9-9b4c-442a-9fce-5683fbf58ff3";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
      "noatime"
    ];
  };

  fileSystems."/run/media/m57/SSD-Shared" = {
    device = "/dev/disk/by-uuid/40D381F06AC618E5";
    fsType = "ntfs";
    options = [
      "defaults"
      "nofail"
      "uid=1000"
      "gid=100"
    ];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8*1024;
    }
  ];

  # zramSwap = {
  #   enable = true;
  #   algorithm = "zstd";
  #   memoryPercent = 50;
  # };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableAllFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    graphics = {
      enable = true;
    };
  };
}
