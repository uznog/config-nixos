{ config, pkgs, ... }:

let
  mod = "Mod4";
  alt = "Mod1";
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
          "${mod}+space" = "exec rofi -show run -show-icons";
          "${mod}+Ctrl+space" = "exec rofi -show ssh -show-icons";
          "${mod}+Shift+space" = "exec rofi -show combi -show-icons";
          "${alt}+Tab" = "exec rofi -show window -show-icons";
          "${mod}+p" = "exec /home/${config.settings.username}/bin/powermenu";
          "${mod}+Return" = "exec ${config.settings.terminal}";
          "${mod}+F1" = ''exec nvidia-offload mpv --force-window=immediate --window-scale=0.5 "$(xclip -o)"'';
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
      exec_always "if [[ -e $HOME/.background-image ]]; then feh --bg-scale $HOME/.background-image; fi"
      exec_always "autorandr -c"
      bindsym --release Mod4+Shift+Z exec "import png:- | tee /home/${config.settings.username}/usr/screenshots/screenshot_$(date +%F_%T).png | xclip -selection clipboard -t image/png"
      for_window [class="mpv"] floating enable
    '';
  };
}
