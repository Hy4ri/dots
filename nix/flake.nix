{
  description = "a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-alien.url = "github:thiagokokada/nix-alien";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    waller.url = "github:hy4ri/waller";
    frame.url = "github:hy4ri/Frame";
    nvim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    vivaldi-snapshot.url = "github:hy4ri/vivaldi-snapshot-flake";
  };

  outputs = {
    self,
    nixpkgs,
    nix-flatpak,
    nix-alien,
    aagl,
    determinate,
    waller,
    frame,
    vivaldi-snapshot,
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
          {
            imports = [aagl.nixosModules.default];
            nix.settings = aagl.nixConfig;
            programs.anime-game-launcher.enable = true;
          }
          ({self, ...}: {
            nixpkgs.overlays = [
              self.inputs.nix-alien.overlays.default #alien
              self.inputs.waller.overlays.default  #Waller
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
