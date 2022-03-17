{
  inputs = {
    # nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable-small;
    nixpkgs.url = github:NixOS/nixpkgs/fcd48a5a0693f016a5c370460d0c2a8243b882dc;

    nixos-stable.url = github:NixOS/nixpkgs/nixos-21.11;
    nixos-hardware.url = github:NixOS/nixos-hardware;

    utils.url = github:gytis-ivaskevicius/flake-utils-plus/v1.3.1;

    sops-nix.url = github:Mic92/sops-nix;

    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    dotfiles.url = github:uznog/dotfiles;
    dotfiles.flake = false;
  };

  outputs = inputs@
  { self
  , utils
  , nixpkgs, nixos-hardware, home-manager
  , sops-nix, dotfiles, ... }:

  let
    inherit (utils.lib) mkFlake exportModules;
  in
  mkFlake rec {
    inherit self inputs;

    nix = {
      generateNixPathFromInputs = true;
      generateRegistryFromInputs = true;
    };

    supportedSystems = [ "x86_64-linux" ];


    channelsConfig = {
      allowUnfree = true;
    };

    overlay = import ./overlays;

    channels.nixpkgs.overlaysBuilder = channels: [
      self.overlay
    ];

    hostDefaults.modules = [
      home-manager.nixosModules.home-manager
      { home-manager.useGlobalPkgs = true; }
      sops-nix.nixosModules.sops

      ./common.nix
      ./modules/settings.nix
      ./modules/sops.nix
    ];

    hosts = {
      snowxps = {
        system = "x86_64-linux";
        modules = [
          ./hosts/snowxps
          nixos-hardware.nixosModules.dell-xps-15-9500-nvidia
        ];
        specialArgs = { inherit inputs dotfiles; };
      };
    };

    outputsBuilder = channels: with channels.nixpkgs; {
      devShell = mkShell {
        name = "sysconfig";
        buildInputs = [
          git
          sops
        ];
      };
    };
  };
}
