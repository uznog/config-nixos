{ pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    ferdi
    signal-desktop
  ];
}
