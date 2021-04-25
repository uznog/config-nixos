{ config, pkgs, ... }:

with pkgs.lib;
{
  home.packages = with pkgs; [
    mpv
    youtube-dl
    syncplay
  ];

  xdg.configFile."mpv".source = ../dotfiles/mpv;
}
