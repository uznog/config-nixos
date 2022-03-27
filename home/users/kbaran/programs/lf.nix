{ pkgs, dotfiles, ... }:

let
  lfcd = pkgs.writeScriptBin "lfcd" ''
    #!${pkgs.stdenv.shell}
    
    tmp="$(mktemp)"
    fid="$(mktemp)"
    ${pkgs.lf}/bin/lf -command '$printf $id > '"$fid"'\' -last-dir-path="$tmp" "$@"
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
  '';
in
{
  home.packages = with pkgs; [
    atool
    archivemount
    exiftool
    file
    highlight
    mediainfo
    trash-cli

    lfcd
  ];

  xdg.configFile."diricons".source = "${dotfiles}/lf/diricons";

  programs.lf = {
    enable = true;
    commands = {
      bulk_rename = ''''${{
          old=$(mktemp)
          new=$(mktemp)
          [ -n $fs ] && fs=$(ls)
          printf "$fs\n" > $old
          printf "$fs\n" > $new
          $EDITOR $new
          [ $(cat $new | wc -l) -ne $(cat $old | wc -l) ] && exit
          paste $old $new | while read names; do
              src=$(printf $names | cut -f1)
              dst=$(printf $names | cut -f2)
              [ $src = $dst ] && continue
              [ -e $dst ] && continue
              mv $src $dst
          done
          rm $old $new
          lf -remote "send $id unselect"
        }}
      '';
      cdc = ''''${{
          set -f
          dir="$(xclip -o -selection clipboard)"
          if [ -d "''${dir}" ]; then
              dir_quoted="$(readlink -f "''${dir}" | sed 's|\(.*\)|"\1"|')"
              lf -remote "send ''${id} cd ''${dir_quoted}"
          else
              echo "can't find directory"
              exit 1
          fi
        }}
      '';
      checkSops = ''&{{
        if ${pkgs.yq}/bin/yq .sops.version $1 &> /dev/null; then
          ${pkgs.sops}/bin/sops $1
        else
          nvim $1
        fi
        }}
      '';
      compress = ''''${{
          [ -z "$1" ] && exit 1
          ''${EXT:="''${2:-tar.gz}"}

          if [ "$EXT" = "zip" ]; then
              if zip -rj "$1.$EXT" $fx; then
                  lf -remote "send $id echo $1.$EXT created successfully"
              else
                  lf -remote "send $id echo failed to create $1.$EXT"
              fi
          else
              DIR="$1_$$"; fDIR="$(pwd)"; mkdir "$DIR" || exit 1
              if cp -r $fx "$DIR"; then
                  cd "$DIR"
                  set +f # shell expansion
                  if apack "$fDIR/$1.$EXT" *; then
                      lf -remote "send $id echo $1.$EXT created successfully"
                  else
                      lf -remote "send $id echo failed to create $1.$EXT"
                  fi
              fi
              rm -rf "$fDIR/$DIR"
          fi

        }}
      '';
      disk_usage = ''&{{
          set -f
          du="Total $(du -hs .)"
          lf -remote "send $id echo $du"
        }}
      '';
      file_usage = ''&{{
          set -f
          du="Total $(du -hsc $fx | awk 'END{print $1}')"
          lf -remote "send $id echo $du"
        }}
      '';
      makedir = ''%{{
          set -f

          name="$(echo "$@" | tr -d "\n")"
          if [ -d "$name" ]; then
                  printf "dir exists"
          else
                  mkdir -p -- "$name"
          fi
        }}
      '';
      open = ''&{{
        case "$f" in
          *.tar.bz|*.tar.bz2|*.tbz|*.tbz2|*.tar.gz|*.tgz|*.tar.xz|*.txz|*.zip|*.rar|*.iso)
            file_dir="$(dirname "$f")"
            filename=".$(basename "$f")"
            mntdir="$file_dir/$filename-archivemount"

            if [ ! -d "$mntdir" ]; then
              mkdir "$mntdir"
              archivemount "$f" "$mntdir"
              echo "$mntdir" >> "/tmp/__lf_archivemount_$id"
            fi

            lf -remote "send $id cd \"$mntdir\""
            lf -remote "send $id reload"
          ;;
          *)
            case $(file --mime-type $f -b) in
            *.tar.bz|*.tar.bz2|*.tbz|*.tbz2|*.tar.gz|*.tgz|*.tar.xz|*.txz|*.zip|*.rar|*.iso)
              mntdir="$f-archivemount"
              if [ ! -d "$mntdir" ]; then
                mkdir "$mntdir"
                archivemount "$f" "$mntdir"
                echo "$mntdir" >> "/tmp/__lf_archivemount_$id"
              fi
              lf -remote "send $id cd \"$mntdir\""
              lf -remote "send $id reload"
            ;;
            text/*) "$EDITOR" -- $fx;;
            image/*) feh $fx;;
            *) xdg-open $fx;;
          esac
          ;;
        esac
      }}
      '';
      put-progress = ''&{{
        set -f

        load=$(lf -remote 'load')
        mode=$(printf "%s\n" "$load" | sed -n '1p')
        list=$(printf "%s\n" "$load" | sed '1d')

        if [ $mode = 'copy' ]; then
                rsync -a --ignore-existing --skip-compress \
                --inplace --info=PROGRESS2 $list . \
                | stdbuf -i0 -o0 -e0 tr '\r' '\n' \
                | while read line; do
                        lf -remote "send $id echo $line"
                done
        fi

        lf -remote "$(printf 'save\nmove\n\n')"
        lf -remote 'send load'
        lf -remote 'send sync'
      }}
      '';
      rename = ''&{{
          if [ -e "$*" ]; then
              lf -remote "send $id echo file exists"
          else
              mv "$f" "$*"
          fi
        }}
      '';
      underscore = ''&{{
          set -f
          for i in $fx; do
                  new="$(printf "%s\n" "$i" | awk '{$1=$1}1' OFS="_")"
                  mv "$i" "$new"
          done
        }}
      '';
    };
    extraConfig = ''
      map - &printf "%s" "$fx" | xclip -selection clipboard
      map _ &printf "%s" "$fx" | sed 's|.*/||g' | xclip -selection clipboard
      set autoquit
    '';
    cmdKeybindings = {
    };
    keybindings = {
      zp = "set preview!";
      zh = "set hidden!";
      zn = "set info";
      zs = "set info size";
      zt = "set info time";
      za = "set info size:time";
      sn = ":set sortby natural; set info";
      ss = ":set sortby size; set info size";
      st = ":set sortby time; set info time";
      gR = "cd /";
      gB = "cd /sbin";
      gE = "cd /etc";
      gU = "cd /usr";
      gD = "cd /dev";
      gO = "cd /opt";
      gV = "cd /var";
      gM = "cd /media";
      gh = "cd ~";
      gb = "cd ~/bin";
      ge = "cd ~/etc";
      gu = "cd ~/usr";
      gv = "cd ~/var";
      gs = "cd ~/src";
      gc = "cd ~/etc/config-nixos";
      gf = "cd ~/usr/downloads_firefox";
      gt = "cd ~/.local/share/Trash";
      gp = "cd &xclip -o -selection clipboard";
      d = null;
      dd = "cut";
      dD = "$trash $f";
      dR = "delete";
      P = "put-progress";
      e = ''$sops $f || vim $f'';
      i = ''$bat --style full $f'';
      w = "$$SHELL";
      x = "$$f";
      X = "!$f";
      o = "$rifle -- $f";
      O = "&rifle -- $f";
      L = "$tmux next-window";
      H = "$tmux previous-window";
      _ = ''&printf "%s" "$fx" | sed 's|.*/||g' | xclip -selection clipboard'';
      A = ''$name="''${f##*/}"; lf -remote "send ''${id} push \:rename<space>''${name%.*}"'';
      a = ''$lf -remote "send $id push \:rename<space>''${f##*/}"'';
      R = "bulk_rename";
      m = "push \:makedir<space>";
      u = "disk_usage";
      U = "file_usage";
      C = "unselect";
      "<enter>" = "shell";
      "<c-space>" = "push :glob-select<space>";
      "<c-y>" = "up";
      "<c-e>" = "down";
      "<c-n>" = "$tmux new-window lf";
    };
    previewer = {
      keybinding = null;
      source = "${dotfiles}/lf/previewer.sh";
    };
    settings = {
      hidden = true;
      icons = true;
      ifs = "\\n";
      incsearch = true;
      info = "size:time";
      ratios = "2:6:8";
      scrolloff = 5;
    };
  };
}
