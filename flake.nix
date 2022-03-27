{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

    nixpkgs-pin.url = github:NixOS/nixpkgs/fcd48a5a0693f016a5c370460d0c2a8243b882dc;

    nixos-stable.url = github:NixOS/nixpkgs/nixos-21.11;

    # https://github.com/NixOS/nixos-hardware/issues/388
    # nixos-hardware.url = github:NixOS/nixos-hardware;
    nixos-hardware.url = github:bbigras/nixos-hardware/intel-gpu;

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
  , nixpkgs, nixpkgs-pin, nixos-hardware, home-manager
  , sops-nix, dotfiles, ... }:

  let
    inherit (utils.lib) mkFlake exportModules;
    system = "x86_64-linux";
    pinned-pkgs = nixpkgs-pin.legacyPackages.x86_64-linux;
  in
  mkFlake rec {
    inherit self inputs;

    nix = {
      generateNixPathFromInputs = true;
      generateRegistryFromInputs = true;
    };

    supportedSystems = [ system ];

    channelsConfig = {
      allowUnfree = true;
    };

    overlay = import ./overlays;

    channels.nixpkgs.overlaysBuilder = channels: [
      self.overlay
    ];

    hostDefaults.modules = [
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
      { 
        home-manager.useGlobalPkgs = true; 
      }

      ./common.nix
      ./modules/settings.nix
      ./modules/sops.nix
    ];

    hosts = {
      snowxps = {
        inherit system;
        modules = [
          nixos-hardware.nixosModules.dell-xps-15-9500-nvidia
          ./hosts/snowxps
        ];
        specialArgs = { inherit inputs pinned-pkgs dotfiles; };
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
