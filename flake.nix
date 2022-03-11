{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/d5f237872975e6fb6f76eef1368b5634ffcd266f";

    nixos-stable.url = "github:NixOS/nixpkgs/nixos-21.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.3.1";

    agenix.url = "github:ryantm/agenix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sensitive.url = "path:/etc/nixos/sensitive";
    sensitive.flake = false;

    dotfiles.url = "github:uznog/dotfiles";
    dotfiles.flake = false;
  };

  outputs = inputs@
  { self
  , utils, agenix 
  , nixpkgs, nixos-hardware, home-manager
  ,  dotfiles, sensitive, ... }:

  let
    inherit (utils.lib) mkFlake exportModules;
    pkgs = self.pkgs.x86_64-linux.nixpkgs;
  in
  mkFlake rec {
    inherit self inputs;

    supportedSystems = [ "x86_64-linux" ];

    overlay = import ./overlays;

    channelsConfig = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };

    channels.nixpkgs.overlaysBuilder = channels: [
      self.overlay
    ];

    hostDefaults.modules = [
      ./common.nix
      ./modules/settings.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];

    hosts = {
      nixos = {
        system = "x86_64-linux";
        modules = [
          ./hosts/xps/configuration.nix
          nixos-hardware.nixosModules.dell-xps-15-9500-nvidia
          agenix.nixosModule
        ];
        specialArgs = { inherit dotfiles sensitive; };
      };
    };

    outputsBuilder = channels: with channels.nixpkgs; {
      devShell = mkShell {
        name = "sysconfig";
        buildInputs = [
          agenix.defaultPackage.x86_64-linux
          git
        ];
      };
    };
  };
}
