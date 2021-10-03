{ config, pkgs, ... }:

{
  import = [
    ./sxhkd.nix
  ];

  xsession.windowManager.bspwm = {
    enable = true;


  };
}
