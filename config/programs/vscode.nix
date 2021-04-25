{ config, pkgs, ... }:

with pkgs.lib;
{
  programs.vscode = {
    enable = true;
  };
}
