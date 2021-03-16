{ config, pkgs, ... }:

{
  imports = [
    ./tmux.nix
    ./bash.nix
    ./lf.nix
    ./starship.nix
  ];
}
