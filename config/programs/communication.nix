{ pkgs, ... }:

let
  nixos-master = import <nixos-master> { config.allowUnfree = true; };
in
{
  home.packages = with pkgs; [
    nixos-master.discord
    rambox
    signal-desktop
  ];
}
