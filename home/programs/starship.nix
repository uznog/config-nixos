{ config, pkgs, ... }:

with pkgs.lib;
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      add_newline = true;
      character = {
        success_symbol = "[\\$](bold green)";
        error_symbol = "[\\$](bold red)";
        vicmd_symbol = "[V](bold green)";
      };

      aws = {
        disabled = false;
        format = "on [$symbol$profile \\($region\\)]($style) ";
        symbol = "";
      };

      gcloud = {
        disabled = false;
        format = "[$symbol$active \\($region\\)]($style) ";
        symbol = " ";
      };

      kubernetes = {
        disabled = false;
      };
    };
  };

}
