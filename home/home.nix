{ config, pkgs, ... }:

let
  customPkgs = import ../pkgs;
in
  {
    imports = [
      ../modules/settings.nix
      ./dev
    #./wm
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
      unzip
      xclip
      watson
      zip
      zoom-us
    ]
    ++ customPkgs;

    sessionPath = [
      "~/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      PAGER = "bat";
      MANPAGER = "bat";
      BROWSER = "firefox";
    };
  };

  xdg.configFile."alacritty/alacritty.yml".source = ./dotfiles/alacritty.yml;
}
