{
  description = "a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = { self, nixpkgs, nix-flatpak, hyprland, ... }@inputs: {
    nixosConfigurations = {
      hyari = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        # Add an overlay to fix libvdpau-va-gl
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              (final: prev: {
                libvdpau-va-gl = prev.libvdpau-va-gl.overrideAttrs (old: {
                  cmakeFlags = (old.cmakeFlags or []) ++ [
                    "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
                  ];
                });
              })
            ];
          })
        ];
      };
    };
  };
}
