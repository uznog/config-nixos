{ pkgs, ... }:

with pkgs;
let
  pythonPkgs = pythonPackages: with pythonPackages; [
    requests
    ec2instanceconnectcli 
  ];
in
{
  home.packages = [
    (python3.withPackages pythonPkgs)
  ];
}
