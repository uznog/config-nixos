{ config, pkgs, ... }:

with pkgs.lib;
{
  programs.bash = {
    enable = true;
    historyFile = "\$HOME/.config/bash/.bash_history";
    shellAliases = {
      "ll" = "ls -al";
      "ns" = "nix-shell --command bash";
      "vim" = "nvim";
      "ga" = "git add";
      "gc" = "git commit -m";
      "gp" = "git push";
      "gm" = "git merge";
      "gs" = "git status";
      "gd" = "git diff";
      "gl" = "git log --pretty=oneline";
      "hm" = "home-manager -f $HOME/etc/config-nixos/config/home.nix";
    };
    initExtra = ''
      hg() { history | grep "$1"; }
      pg() { ps aux | grep "$1"; }
      lfcd () {
        tmp="$(mktemp)"
        fid="$(mktemp)"
        lf -command '$printf $id > '"$fid"'\' -last-dir-path="$tmp" "$@"
        id="$(cat "$fid")"
        archivemount_dir="/tmp/__lf_archivemount_$id"
        if [ -f "$archivemount_dir" ]; then
            cat "$archivemount_dir" | \
                while read -r line; do
                    sudo umount "$line"
                    rmdir "$line"
                done
            rm -f "$archivemount_dir"
        fi
        if [ -f "$tmp" ]; then
            dir="$(cat "$tmp")"
            rm -f "$tmp"
            if [ -d "$dir" ]; then
                if [ "$dir" != "$(pwd)" ]; then
                    cd "$dir"
                fi
            fi
        fi
    }
    bind '"\C-o":"lfcd\C-m"'

    '';
    sessionVariables = {
      EDITOR = "nvim";
      PAGER = "less";
      MANPAGER = "less";
    };
    shellOptions = [
    "autocd" "cdspell" "dirspell" "globstar" # bash >= 4
    "cmdhist" "nocaseglob" "histappend" "extglob"
    ];
  };
}
