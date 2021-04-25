{ config, pkgs, ... }:

{
  imports = [
    ./autorandr.nix
    ./bash.nix
    ./direnv.nix
    ./dunst.nix
    ./git.nix
    ./k8s.nix
    ./lf.nix
    ./neovim.nix
    ./mpv.nix
    ./starship.nix
    ./tmux.nix
    ./vscode.nix
  ];
}
