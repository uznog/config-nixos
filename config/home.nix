{ config, pkgs, ... }:

let
  tidal = pkgs.writeScriptBin "tidal" ''
    #!${pkgs.stdenv.shell}
    ${pkgs.chromium}/bin/chromium --app="https://listen.tidal.com"
  '';
in
{
  imports = [
    ../modules/settings.nix
    ./dev
    ./wm
    ./programs
    ./services
  ];

  nixpkgs.config = import ../nixpkgs.nix;

  home = {
    packages = with pkgs; [
      (import <nixos-unstable> {config.allowUnfree = true;})._1password
      acpilight
      alacritty
      discord
      docker-compose
      dunst
      feh
      ffmpeg
      firefox
      fzf
      imagemagick
      jq
      killall
      lxappearance
      okular
      pavucontrol
      pv
      rofi
      tidal
      unzip
      xclip
      zip
      zoom-us
    ];
    sessionPath = [
      "~/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      PAGER = "less";
      MANPAGER = "less";
      BROWSER = "firefox";
    };
  };

  xdg.configFile."alacritty/alacritty.yml".source = ./dotfiles/alacritty.yml;
}
