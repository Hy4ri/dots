{
  description = "a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-guiutils.url = "github:hyprwm/hyprland-guiutils";
    nix-alien.url = "github:thiagokokada/nix-alien";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
  };

  outputs = { self, nixpkgs, nix-flatpak, hyprland, hyprland-guiutils, nix-alien, aagl, determinate, ... }@inputs: {
    nixosConfigurations = {
      hyari = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = { inherit self system inputs; };
        modules = [
          ./configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
          determinate.nixosModules.default
          {
            imports = [ aagl.nixosModules.default ];
            nix.settings = aagl.nixConfig;
            programs.anime-game-launcher.enable = true;
          }
          ({ self, ... }: {
            nixpkgs.overlays = [
              self.inputs.nix-alien.overlays.default
               self.inputs.hyprland-guiutils.overlays.default
            ];
          })
        ];
      };
    };
  };
}
