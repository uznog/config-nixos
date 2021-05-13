{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in
with pkgs.lib;
{
  nixpkgs.config = import ../../nixpkgs.nix;

  home.packages = with unstable; [
    k9s
    google-cloud-sdk
    kubernetes-helm
    kubectx
    kubectl
  ];
}
