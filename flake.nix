# flake.nix
{
  description = "My NixOS configuration";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  };
  outputs = { self, nixpkgs }: {
    # System configuration
    nixosConfigurations.mySystem = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix
      ];
    };
    defaultPackage.x86_64-linux = self.nixosConfigurations.mySystem;
  };
}
