{ config, pkgs, ... }:

with pkgs.lib;
{
  programs.git = {
    enable = true;
    userName = "uznog";
    userEmail = "konrad.baran224@gmail.com";
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
      init.defaultBranch = "master";
    };

    includes = [
      {
        condition = "gitdir:~/src/snowdog/";
        contents = {
          user = { name = "Konrad Baran"; email = "konrad.baran@snow.dog"; };
          commit.gpgSign = true;
          tag.gpgSign = true;
        };
      }
      {
        condition = "gitdir:**";
        contents = {
          user = { name = "Konrad Baran"; email = "konrad.baran224@gmail.com"; };
          commit.gpgSign = true;
          tag.gpgSign = true;
        };
      }
    ];
  };
}
