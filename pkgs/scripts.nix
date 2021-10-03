{ pkgs ? import <nixpkgs> {} }:

[
  (pkgs.writeScriptBin "tidal" ''
    #!${pkgs.stdenv.shell}
    ${pkgs.chromium}/bin/chromium --app="https://listen.tidal.com"
  '')

  # https://github.com/NixOS/nixpkgs/issues/64965 
  (pkgs.writeScriptBin "edit-l2tp-vpn" ''
    #!${pkgs.stdenv.shell}
    ${pkgs.networkmanagerapplet}/bin/nm-connection-editor
  '')

  (pkgs.writeScriptBin "boot2windows" ''
    #!${pkgs.stdenv.shell}
    sudo ${pkgs.grub2}/bin/grub-reboot "Windows 10"
    systemctl reboot
  '')
]
