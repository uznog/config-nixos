{ config, pkgs, ... }:

let
  tidal = pkgs.writeScriptBin "tidal" ''
    #!${pkgs.stdenv.shell}
    chromium --app="https://listen.tidal.com"
  '';
in
with pkgs.lib;
{
  imports = [
    ../modules/settings.nix
    ./programs
    ./i3
  ];

  nixpkgs.config = import ../nixpkgs.nix;

  home = {
    packages = with pkgs; [
      alacritty
      chromium
      discord
      dunst
      feh
      ffmpeg
      ferdi
      firefox
      fzf
      home-manager
      imagemagick
      jq
      killall
      lxappearance
      okular
      pavucontrol
      pv
      rofi
      signal-desktop
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
