{ pkgs, ... }:

{
  # nix / nixpkgs related config
  nix = {
    trustedUsers = [ "root" "@wheel" ];
    package = pkgs.nixUnstable;
  };
  nixpkgs.config = import ./nixpkgs.nix;
}
