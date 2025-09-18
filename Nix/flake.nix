{
  description = "a falke";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprqt6engine.url = "github:hyprwm/hyprqt6engine";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = {
    self,
    nixpkgs,
    nix-flatpak,
    hyprqt6engine,
    ...
  }: {
    nixosConfigurations = {
      hyari = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
        ];
        specialArgs = {inherit hyprqt6engine;};
      };
    };
  };
}
