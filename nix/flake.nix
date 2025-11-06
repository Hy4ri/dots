{
  description = "NixOS configuration for hyari's system";

  inputs = {
    # Main NixOS package repository
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Flatpak management in NixOS
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    
    # MangoHud overlay management
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-flatpak, mango, ... }@inputs: {
    nixosConfigurations = {
      hyari = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # MangoHud overlay
          mango.nixosModules.mango
          
          # Main configuration
          ./configuration.nix
          
          # Flatpak module
          nix-flatpak.nixosModules.nix-flatpak
          
          # Fix for libvdpau-va-gl CMake policy
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              (final: prev: {
                libvdpau-va-gl = prev.libvdpau-va-gl.overrideAttrs (old: {
                  cmakeFlags = (old.cmakeFlags or []) ++ [
                    "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
                  ];
                });
              })
            ];
          })
        ];
      };
    };
  };
}
