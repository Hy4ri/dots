{
  description = "a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-alien.url = "github:thiagokokada/nix-alien";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    frame.url = "github:hy4ri/Frame";
    vivaldi-snapshot.url = "github:hy4ri/vivaldi-snapshot-flake";
    vivaldi-stable.url = "github:hy4ri/vivaldi-snapshot-flake/stable";
    hyprland.url = "github:hyprwm/hyprland";
    quickshell.url = "git+https://git.outfoxxed.me/quickshell/quickshell";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
  };

  outputs = {
    self,
    nixpkgs,
    nix-index-database,
    nix-flatpak,
    determinate,
    ...
  } @ inputs: {
    nixosConfigurations = {
      hyari = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {inherit self system inputs;};
        modules = [
          ./configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
          determinate.nixosModules.default
          nix-index-database.nixosModules.default
          {programs.nix-index-database.comma.enable = true;}
          ({self, ...}: {
            nixpkgs.overlays = [
              self.inputs.nix-alien.overlays.default #alien
              self.inputs.frame.overlays.default #frame
              self.inputs.vivaldi-stable.overlays.default #vivaldi
              self.inputs.vivaldi-snapshot.overlays.default #vivaldi-snapshot
            ];
          })
        ];
      };
    };
  };
}
