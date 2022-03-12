{ config, pkgs }:

pkgs.writeScriptBin "run-minio" ''
  #!${pkgs.stdenv.shell}

  CFG_ROOT="/home/kbaran/etc/config-sensitive/minio"
  CFG_CREDENTIALS="''${CFG_ROOT}/credentials"
  CFG_DIR="''${CFG_ROOT}/conf.d"

  API_ADDRESS=":9002"
  CONSOLE_ADDRESS=":9003"

  source $CFG_CREDENTIALS
  conf="$(ls -l $CFG_DIR | grep -v total | awk '{ print $9 }' | ${pkgs.fzf}/bin/fzf )"

  conf_full_path="''${CFG_DIR}/''${conf}"
  gateway="$(cat $conf_full_path | cut -d':' -f1)"
  project="$(cat $conf_full_path | cut -d':' -f2)"

  ${pkgs.minio}/bin/minio gateway "$gateway" "$project" --address "$API_ADDRESS" --console-address "$CONSOLE_ADDRESS"
''
