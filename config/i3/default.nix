{ config, pkgs, ... }:

{
  imports = [
    ./i3.nix
    ./polybar.nix
    ./rofi.nix
    ./picom.nix
  ];
}
