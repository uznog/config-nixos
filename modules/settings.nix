{ lib, config, ... }:

with lib;
{
  options.settings = {

    user = {
      name = mkOption {
        type = with types; uniq str;
        default = "kbaran";
        description = "User's username to be used within system";
      };

      fullname = mkOption {
        type = with types; uniq str;
        default = "Konrad Baran";
        description = "User's full ID";
      };

      email = mkOption {
        type = with types; uniq str;
        default = "konrad.baran224@gmail.com";
        description = "Email address to use";
      };

      homeDir = mkOption {
        type = types.str;
        default = "/home/${config.settings.user.name}";
        description = "Location of user's home directory";
      };
    };

    host = {
      isVirtual = mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "True if host is a virtual machine";
      };

      hostsFile = mkOption {
        type = types.path;
        default = config.settings.user.homeDir + "/etc/config-sensitive/hosts";
        description = "Path to file containing hosts in /etc/hosts manner to be used";
      };
    };

    terminal = mkOption {
      type = with types; uniq str;
      default = "alacritty";
    };

    fontName = mkOption {
      type = types.str;
      default = "SauceCodePro Nerd Font";
    };

    fontSize = mkOption {
      type = types.int;
      default = 12;
    };

    kbLayout = mkOption {
      type = types.str;
      default = "pl";
    };

    xkbFile = mkOption {
      type = with types; uniq str;
      default = "none";
      description = ''
        Filename of the xkb file to load (or "none" if no keyboard
        layout is desired). File is specified without extension and
        must be present in the xkb directory.
      '';
    };
  };
}
