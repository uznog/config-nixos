{ pkgs, ... }:

with pkgs.lib;
{
  programs.go = {
    enable = true;
    goPath = "src/go";
    goBin = "src/go/bin";
  };
}
