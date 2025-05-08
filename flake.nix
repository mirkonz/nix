{
  description = "MacOS configuration using Nix (incl. Home Manager, Homebrew and MAS)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs = {
        nix-darwin.follows = "nix-darwin";
        nixpkgs.follows = "nixpkgs";
      };
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      homebrew-bundle,
      mac-app-util,
      ...
    }:
    let
      username = "mirko";
      system = "aarch64-darwin";
      inputs = {
        inherit
          self
          nixpkgs
          home-manager
          nix-darwin
          nix-homebrew
          homebrew-core
          homebrew-cask
          homebrew-bundle
          mac-app-util
          ;
      };
    in
    {
      darwinConfigurations.${username} = nix-darwin.lib.darwinSystem {
        system = system;
        modules = [
          ./dock.nix
          ./darwin.nix
          ./home.nix
          ./system-defaults.nix
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
        ];
        specialArgs = {
          inherit self username inputs;
        };
      };
    };
}
