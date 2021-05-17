{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in
with pkgs.lib;
{
  home.packages = with unstable; [
    k9s
    google-cloud-sdk
    kubernetes-helm
    kubectx
    kubectl
  ];
}
