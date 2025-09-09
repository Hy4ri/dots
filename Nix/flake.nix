{
  description = "a falke";
  inputs = {nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";};
  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      hyari = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./configuration.nix];
      };
    };
  };
}
