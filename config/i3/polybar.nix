{ config, pkgs, ... }:

with pkgs.lib;
{
  imports = [
    ../../modules/settings.nix
  ];

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
      githubSupport = true;
    };
    config = ../dotfiles/polybar.conf;
    script = "polybar top &";
  };

}
