{ pkgs, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
      githubSupport = true;
    };
    config = ../dotfiles/polybar.conf;
    script = ''
      polybar xps &
      polybar benq &
    '';
  };

}
