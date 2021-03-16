{ config, pkgs, ... }:

let
  mod = "Mod4";
in
with pkgs.lib;
{
  imports = [
    ../../modules/settings.nix
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      window.titlebar = false;
      modifier = mod;
      bars = [];
      gaps = {
        bottom = 10;
        top = 40;
        left = 8;
        right = 8;
        inner = 8;
      };
      keybindings = mkOptionDefault(
        {
          "${mod}+space" = "exec ${pkgs.rofi}/bin/rofi -show run";
          "${mod}+Return" = "exec ${config.settings.terminal}";
          "${mod}+q" = "kill";
          "${mod}+Shift+q" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";
          "${mod}+Control+q" = "restart";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";
          "${mod}+h" = "focus left";
          "${mod}+Shift+J" = "move down";
          "${mod}+Shift+K" = "move up";
          "${mod}+Shift+L" = "move right";
          "${mod}+Shift+H" = "move left";
          "${mod}+y" = "bar mode toggle";
        }
      );
      window = {
        border = 0;
      };
    };
    extraConfig = ''
      focus_wrapping no
      exec_always "if [[ -e $HOME/.background-image ]]; then feh --bg-scale $HOME/.background-image ; fi"
    '';
  };

  #xdg.configFile."i3status/config".source = ./dotfiles/i3status.conf;
}
