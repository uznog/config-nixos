{ pkgs }:

pkgs.writeScriptBin "tidal" ''
  #!${pkgs.stdenv.shell}
  ${pkgs.chromium}/bin/chromium --app="https://listen.tidal.com"
''
