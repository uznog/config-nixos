# https://github.com/NixOS/nixpkgs/issues/64965 

{ pkgs, ... }:

pkgs.writeScriptBin "edit-l2tp-vpn" ''
  #!${pkgs.stdenv.shell}
  ${pkgs.networkmanagerapplet}/bin/nm-connection-editor
''
