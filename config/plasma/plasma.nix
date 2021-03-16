{ config, pkgs, ... }:

let
  nordic = fetchTarball { 
    url = https://github.com/EliverLara/Nordic/archive/v1.9.0.tar.gz;
    sha256 = "18rb9kp3q3sxqyc9x7xnqqpy5zhz1q459yh82a2slbcjzrn8jl06";
  };
in
with pkgs.lib;
{
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
  ];

  xdg.dataFile."plasma/look-and-feel/Nordic" = {
    recursive = true;
    source = nordic + "/kde/look-and-feel";
  };

  xdg.dataFile."plasma/kvantum" = {
    recursive = true;
    source = nordic + "/kde/kvantum";
  };

  xdg.dataFile."aurorae" = {
    recursive = true;
    source = nordic + "/kde/aurorae";
  };

  xdg.dataFile."sddm/Nordic" = {
    recursive = true;
    source = nordic + "/kde/sddm";
  };

}
