{ config, pkgs, ... }:

with pkgs.lib;
{
  services.picom = {
    enable = true;

    activeOpacity = "0.9";

    blur = true;
    blurExclude = [ "class_g = 'polybar'" ];

    experimentalBackends = true;

    fade = true;
    fadeDelta = 5;

    inactiveOpacity = "0.9";
    opacityRule = [
      "100:class_g = 'Firefox'"
      "100:class_g = 'Ferdi'"
      "100:class_g = 'discord'"
      "100:class_g = 'zoom'"
      "100:class_g = 'mpv'"
      "100:class_g = 'polybar'"
      "97:class_g = 'Alacritty' && focused"
      "80:class_g = 'Alacritty' && !focused"
      "97:class_g = 'Code' && focused"
      "80:class_g = 'Code' && !focused"
    ];

    shadow = false;
    shadowExclude = [ "class_g = 'polybar'" ];
    shadowOpacity = "0.25";

  };
}
