{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    k9s
    kube-score
    kubectl
    kubectx
    kubernetes-helm
  ];
}
