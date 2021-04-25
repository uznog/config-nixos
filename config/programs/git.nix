{ config, pkgs, ... }:

with pkgs.lib;
{
  programs.git = {
    enable = true;
    userName = config.settings.name;
    userEmail = "konrad.baran@snow.dog";
    aliases = {
      gss = "status -s -uno";
      gl = "log --oneline --graph";
      ga = "add";
      gc = "commit -m";
      gp = "push";
      gm = "merge";
      gs = "status";
      gd = "diff";
    };
    ignores = [".#*" "*.desktop" "*.lock"];
    extraConfig = {
      branch.autosetuprebase = "never";
      push.default = "simple";
    };
  };
}
