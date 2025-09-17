{
  description = "a falke";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprqt6engine.url = "github:hyprwm/hyprqt6engine";
  };

  outputs = { self, nixpkgs, hyprqt6engine, ... }: {
    nixosConfigurations = {
      hyari = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
        specialArgs = { inherit hyprqt6engine; };
      };
    };
  };
}
