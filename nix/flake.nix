{
  description = "a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
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
          mango.nixosModules.mango
          ./configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
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
