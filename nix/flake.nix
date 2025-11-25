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
    affinity-nix.url = "github:mrshmllow/affinity-nix";
  };

  outputs = { self, nixpkgs, nix-flatpak, hyprland, antigravity-nix, affinity-nix, ... }@inputs: {
    nixosConfigurations = {
      hyari = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
          { environment.systemPackages = [affinity-nix.packages.x86_64-linux.v3];}
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
