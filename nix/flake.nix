{
  description = "a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-alien.url = "github:thiagokokada/nix-alien";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    waller.url = "github:hy4ri/waller";
    frame.url = "github:hy4ri/Frame";
    nvim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    vivaldi-snapshot.url = "github:hy4ri/vivaldi-snapshot-flake";
    hyprland.url = "github:hyprwm/hyprland";
  };

  outputs = {
    self,
    nixpkgs,
    nix-flatpak,
    nix-alien,
    determinate,
    waller,
    frame,
    vivaldi-snapshot,
    hyprland,
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
          ({self, ...}: {
            nixpkgs.overlays = [
              self.inputs.nix-alien.overlays.default #alien
              self.inputs.waller.overlays.default #Waller
              self.inputs.frame.overlays.default #frame
              self.inputs.nvim-nightly.overlays.default #nvim
              self.inputs.vivaldi-snapshot.overlays.default #vivaldi-snapshot
            ];
          })
        ];
      };
    };
  };
}
