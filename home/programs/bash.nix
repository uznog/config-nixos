{ config, nixosConfig, pkgs, ... }:

let
  lfIcons = ''
    LF_ICONS=$(sed ~/.config/diricons \
          -e '/^[ \t]*#/d'       \
          -e '/^[ \t]*$/d'       \
          -e 's/[ \t]\+/=/g'     \
          -e 's/$/ /')
    LF_ICONS=''${LF_ICONS//$'\n'/:}
    export LF_ICONS
  '';

  lfBind = ''
    bind '"\C-o":"source lfcd\C-m"'
  '';

  kindCompletion = ''
    complete -C ${pkgs.minio-client}/bin/mc mc
  '';

  mcComplete = ''
    source <(${pkgs.kind}/bin/kind completion bash)
  '';
in
{
  programs.bash = {
    enable = true;

    historyFile = "${nixosConfig.settings.user.homeDir}/.bash_history";

    shellAliases = {
      "ll" = "ls -al";
      "ns" = "nix-shell --command bash";
      "nr" = "sudo nixos-rebuild";
      "gl" = "git log --oneline --graph";
      "ga" = "git add";
      "gc" = "git commit -m";
      "gp" = "git push";
      "gm" = "git merge";
      "gs" = "git status";
      "gd" = "git diff";
    };

    initExtra = ''
      hg() { history | grep "$1"; }
      pg() { ps aux | grep "$1"; }
    ''
    + lfBind + lfIcons
    + kindCompletion
    + mcComplete;

    sessionVariables = {
      EDITOR = "nvim";
      PAGER = "bat -p";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      SYSTEMD_PAGER = "";
    };

    shellOptions = [
      "autocd" "cdspell" "dirspell" "globstar" # bash >= 4
      "cmdhist" "nocaseglob" "histappend" "extglob"
    ];
  };
}
