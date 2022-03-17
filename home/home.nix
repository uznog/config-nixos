inputs@{ config, pkgs, ... }:

{
  imports = [
    ./dev
    ./programs
    ./services
  ];

  home.stateVersion = "22.05";

  programs.home-manager = {
    enable = true;
  };

  home = {
    packages = with pkgs; [
      boot2windows
      tidal
      edit-l2tp-vpn
      run-minio

      _1password
      _1password-gui
      acpilight
      betterlockscreen
      chromium
      docker-compose
      feh
      ffmpeg
      firefox
      fzf
      gimp
      htop
      imagemagick
      jq
      kdeconnect
      keepassxc
      killall
      lxappearance
      okular
      openssl
      pavucontrol
      postman
      pv
      rofi
      unzip
      xclip
      watson
      zip
      zoom-us
    ];

    sessionPath = [
      "$HOME/bin"
      "$HOME/src/go/bin"
    ];

    sessionVariables = {
      EDITOR = "nvim";
      PAGER = "bat";
      MANPAGER = "bat";
      BROWSER = "firefox";
    };
  };

}
