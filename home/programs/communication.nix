{ pkgs, ... }:

#let
  #nixos-master = import <nixos-master> { config.allowUnfree = true; };
#in
{
  home.packages = with pkgs; [
    discord
    ferdi
    signal-desktop
  ];
}
