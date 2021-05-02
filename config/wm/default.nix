{ config, pkgs, ... }:

{
  imports = [
    ./i3
    #./bspwm
    ./polybar.nix
    ./rofi.nix
    ./picom.nix
  ];
}
