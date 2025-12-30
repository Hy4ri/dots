{pkgs, ...}: {
  boot = {
    tmp.cleanOnBoot = true;
    tmp.useTmpfs = true;
    loader = {
      timeout = 5;
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
      };
    };
    plymouth = {
      enable = true;
      themePackages = [pkgs.adi1090x-plymouth-themes];
      theme = "sliced";
    };
      kernelPackages = pkgs.linuxPackages_lqx;
    # kernelPackages = pkgs.linuxPackages_zen;
    # kernelPackages = pkgs.linux_xanmod_latest;
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco"
      "modprobe.blacklist=iTCO_wdt"
      "usbcore.autosuspend=-1"
    ];
    kernelModules = ["kvm-intel"];

    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.max_map_count" = 16777216;
      "vm.dirty_bytes" = 268435456;
      "vm.dirty_background_bytes" = 67108864;
      "vm.dirty_writeback_centisecs" = 1500;
      "kernel.printk" = "3 3 3 3";
      "kernel.kptr_restrict" = 2;
      "kernel.kexec_load_disabled" = 1;
    };

    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
    };
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };
}
