{
  description = "a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-alien.url = "github:thiagokokada/nix-alien";
    vivaldi-snapshot.url = "github:hy4ri/vivaldi-snapshot-flake";
    vivaldi-stable.url = "github:hy4ri/vivaldi-snapshot-flake/stable";
    opencode.url = "github:hy4ri/opencode-flake";
    hyprland.url = "github:hyprwm/hyprland";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    helium.url = "github:schembriaiden/helium-browser-nix-flake";
  };

  outputs = {
    self,
    nixpkgs,
    nix-index-database,
    ...
  } @ inputs: {
    nixosConfigurations = {
      hyari = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {inherit self system inputs;};
        modules = [
          ./configuration.nix
          nix-index-database.nixosModules.default
          {programs.nix-index-database.comma.enable = true;}
          ({inputs, ...}: {
            nixpkgs.overlays = [
              inputs.nix-alien.overlays.default #alien
              inputs.vivaldi-stable.overlays.default #vivaldi
              inputs.vivaldi-snapshot.overlays.default #vivaldi-snapshot
              inputs.helium.overlays.default #helium
              inputs.opencode.overlays.default #opencode
            ];
          })
        ];
      };
    };
  };
}
