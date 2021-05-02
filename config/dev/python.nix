{ pkgs, ... }:

with pkgs;
let
  pythonPkgs = pythonPackages: with pythonPackages; [
    requests
  ];
in
{
  home.packages = [
    (python3.withPackages pythonPkgs)
  ];
}
