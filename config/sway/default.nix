{ config, pkgs, ... }:

{
  imports = [
    ./sway.nix
    ./kanshi.nix
  ];
}
