{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ xclip kdeconnect ];

  services.xserver = {
    enable = true;
    autorun = true;

    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
      };
    };

    layout = "pl";
    xkbOptions = "ctrl:nocaps";

    desktopManager = {
      plasma5.enable = true;
    };

    displayManager = {
      autoLogin = {
        enable = true;
        user = "${config.settings.user.name}";
      };
      sddm.enable = true;
    };
  };

}
