{ config, pkgs, ... }:

with pkgs.lib;
{
  services.picom = {
    enable = false;

    activeOpacity = "0.9";

    blur = true;
    blurExclude = [ "class_g = 'polybar'" ];

    fade = true;
    fadeDelta = 10;

    inactiveOpacity = "0.9";

    shadow = false;
    shadowExclude = [ "class_g = 'polybar'" ];
    shadowOpacity = "0.25";

  };
}
