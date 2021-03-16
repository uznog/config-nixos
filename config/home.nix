{ config, pkgs, ... }:

with pkgs.lib;
{
  imports = [
    ../modules/settings.nix
    ./programs
    ./i3
  ];

  nixpkgs.config = import ./nixpkgs.nix;

  home.packages = with pkgs; [
    alacritty
    feh
    ffmpeg
    ferdi
    firefox
    home-manager
    jq
    killall
    lxappearance
    neovim
    pv
    signal-desktop
    unzip
    zip
    zoom-us
  ];

  xdg.configFile."alacritty/alacritty.yml".source = ./dotfiles/alacritty.yml;
  xdg.configFile."diricons".source = ./dotfiles/lf-icons;
}
