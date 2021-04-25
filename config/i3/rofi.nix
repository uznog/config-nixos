{ config, pkgs, ... }:

with pkgs.lib;
{
  xdg.configFile."rofi/config".text = ''
    rofi.font: ${config.settings.fontName} 12
    rofi.terminal: ${config.settings.terminal}
    rofi.theme: nord
    rofi.combi-modi: "window,drun,ssh"
  '';
  xdg.configFile."rofi/nord.rasi".source = ../dotfiles/rofi.nord.rasi;
}
