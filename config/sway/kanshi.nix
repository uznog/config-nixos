{ config, pkgs, ... }:

with pkgs.lib;
{

  services.kanshi = {
    enable = true;
    profiles = {
      default = {
        outputs = [
          {
            status = "enable";
            criteria = "Virtual-1";
            mode = "1920x1440@60.000000Hz";
            position = "0,0";
          }
        ];
      };

    };
  };
}
