{
  description = "a falke";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-master,
    ...
  }: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };

    pkgs-master = import nixpkgs-master {
      inherit system;
    };
  in {
    nixosConfigurations = {
      hyari = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix

          {
            nixpkgs.overlays = [
              (final: prev: {
                # hyprland = pkgs-master.hyprland;
              })
            ];
          }
        ];
      };
    };
  };
}
