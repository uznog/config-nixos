{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    k9s
    google-cloud-sdk
    kube-score
    kubectl
    kubectx
    kubernetes-helm
  ];
}
