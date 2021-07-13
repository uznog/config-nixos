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

  programs.home-manager = {
    enable = true;
  };

  home = {
    packages = with pkgs; [
      _1password
      _1password-gui
      acpilight
      alacritty
      betterlockscreen
      docker-compose
      dunst
      feh
      ffmpeg
      firefox
      fzf
      gimp
      imagemagick
      jq
      kdeconnect
      keepassxc
      killall
      lxappearance
      okular
      openssl
      pavucontrol
      pv
      rofi
      tidal
      unzip
      xclip
      watson
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
