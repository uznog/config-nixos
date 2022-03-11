{ config, ... }:

{
  config.settings = {
    user = {
      name = "kbaran";
    };
    services = {
      grafana.enable = true;
      prometheus.enable = false;
      traefik.enable = true;
    };
    terminal = "alacritty";
    fontName = "SauceCodePro Nerd Font";
    fontSize = 12;
    kbLayout = "pl";
    xkbFile = "none";
  };
}
