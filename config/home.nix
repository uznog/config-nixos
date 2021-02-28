{ config, pkgs, ... }:

with pkgs.lib;
{
  imports = [
    ../modules/settings.nix
    ./programs
  ];

  nixpkgs.config = import ./nixpkgs.nix;

  home.packages = with pkgs; [
    alacritty
    feh
    ffmpeg
    firefox
    home-manager
    jq
    killall
    neovim
    pv
    unzip
    zip
  ];


  xdg.configFile."alacritty/alacritty.yml".source = ./dotfiles/alacritty.yml;
}
