inputs@{ config, pkgs, ... }:

let
  boot2windows = pkgs.writeScriptBin "boot2windows" ''
    #!${pkgs.stdenv.shell}
    sudo ${pkgs.grub2}/bin/grub-reboot "Windows 10"
    systemctl reboot
  '';

  tidal = pkgs.writeScriptBin "tidal" ''
    #!${pkgs.stdenv.shell}
    ${pkgs.chromium}/bin/chromium --app="https://listen.tidal.com"
  '';

  # https://github.com/NixOS/nixpkgs/issues/64965 
  edit-l2tp-vpn = pkgs.writeScriptBin "edit-l2tp-vpn" ''
    #!${pkgs.stdenv.shell}
    ${pkgs.networkmanagerapplet}/bin/nm-connection-editor
  '';

  run-minio = pkgs.writeScriptBin "run-minio" ''
    #!${pkgs.stdenv.shell}

    CFG_ROOT="/home/kbaran/etc/config-sensitive/minio"
    CFG_CREDENTIALS="''${CFG_ROOT}/credentials"
    CFG_DIR="''${CFG_ROOT}/conf.d"

    API_ADDRESS=":9002"
    CONSOLE_ADDRESS=":9003"

    source $CFG_CREDENTIALS
    conf="$(ls -l $CFG_DIR | grep -v total | awk '{ print $9 }' | fzf)"

    conf_full_path="''${CFG_DIR}/''${conf}"
    gateway="$(cat $conf_full_path | cut -d':' -f1)"
    project="$(cat $conf_full_path | cut -d':' -f2)"

    ${pkgs.minio}/bin/minio gateway "$gateway" "$project" --address "$API_ADDRESS" --console-address "$CONSOLE_ADDRESS"
  '';
in
{
  imports = [
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

  home.enableNixpkgsReleaseCheck = false;
}
