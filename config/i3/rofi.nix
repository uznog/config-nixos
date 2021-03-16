{ config, pkgs, ... }:

with pkgs.lib;
{
  xdg.configFile."rofi/config".source = ../dotfiles/rofi;
  xdg.configFile."rofi/nord.rasi".source = ../dotfiles/rofi.nord.rasi;
}
