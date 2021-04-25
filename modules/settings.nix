{ config, pkgs, lib, ... }:

with lib;

{
  options = {
    settings = {
      name = mkOption {
        default = "Konrad Baran";
        type = with types; uniq str;
      };
      username = mkOption {
        default = "kbaran";
        type = with types; uniq str;
      };
      email = mkOption {
        default = "konrad.baran224@gmail.com";
        type = with types; uniq str;
      };
      terminal = mkOption {
        default = "alacritty";
        type = with types; uniq str;
      };
      fontName = mkOption {
        default = "SauceCodePro Nerd Font";
        type = with types; uniq str;
      };
      fontSize = mkOption {
        default = 12;
        type = types.int;
      };
      kbLayout = mkOption {
        default = "pl";
        type = types.str;
      };
      xkbFile = mkOption {
        default = "none";
        type = with types; uniq str;
        description = ''
          Filename of the xkb file to load (or "none" if no keyboard
          layout is desired). File is specified without extension and
          must be present in the xkb directory.
        '';
      };
    };
  };
}
