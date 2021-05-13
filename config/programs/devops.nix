{ config, pkgs, ... }:

{
  nixpkgs.config = import ../../nixpkgs.nix;

  home.packages = with pkgs; [
    ansible_2_9
    httpie
    vagrant
  ];
}
