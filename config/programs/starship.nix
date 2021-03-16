{ config, pkgs, ... }:

with pkgs.lib;
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  xdg.configFile."starship.toml".source = ../dotfiles/starship.toml;
}
