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
    system = "aarch64-linux";
    inherit (nixpkgs.lib) nixosSystem;
    nixpkgsArgs = {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations."thinkpad" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit system nixpkgs; };
      modules = [({pkgs, ...}: {
        nixpkgs.overlays = [ inputs.nixpkgs-wayland.overlay ];
        })
	    ./hardware-configuration.nix
	    ./configuration.nix
      ];
    };
  };
}
