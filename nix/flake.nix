{
  description = "a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    hyprland.url = "github:hyprwm/Hyprland";
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs = { self, nixpkgs, chaotic, nix-flatpak, hyprland, antigravity-nix, ... }@inputs: {
    nixosConfigurations = {
      hyari = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          chaotic.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              inputs.antigravity-nix.overlays.default
            ];
          })
        ];
      };
    };
  };
}
