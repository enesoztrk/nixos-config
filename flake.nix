# SPDX-License-Identifier: MIT
{
  description = "NixOS for thinkpad";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs,  ... } :
  let
    system = "x86_64-linux";
    inherit (nixpkgs.lib) nixosSystem;
    nixpkgsArgs = {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations."thinkpad" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit system nixpkgs; };
      modules = [
	    ./hardware-configuration.nix
	    ./configuration.nix
      ];
    };
  };
}
