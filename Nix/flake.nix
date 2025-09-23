{
  description = "a falke";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprqt6engine.url = "github:hyprwm/hyprqt6engine";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = {
    self,
    nixpkgs,
    nix-flatpak,
    hyprland,
    hyprqt6engine,
    ...
  }@inputs: {
    nixosConfigurations = {
      hyari = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
        ];
        specialArgs = {inherit hyprqt6engine;
          inputs = inputs;};
      };
    };
  };
}
