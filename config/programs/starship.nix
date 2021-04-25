{ config, pkgs, ... }:

with pkgs.lib;
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    package = (import <nixos-unstable> {}).starship;

    settings = {
      add_newline = true;
      character = {
        success_symbol = "[\\$](bold green)";
        error_symbol = "[\\$](bold red)";
        vicmd_symbol = "[V](bold green)";
      };
    };
  };

  #xdg.configFile."starship.toml".source = ../dotfiles/starship.toml;
}
