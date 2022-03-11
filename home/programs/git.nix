{ nixosConfig, ... }:

{
  programs.git = {
    enable = true;
    userName = "uznog";
    userEmail = nixosConfig.settings.user.email;
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
      # Personal
      {
        condition = "gitdir:**";
        contents = {
          user = { name = nixosConfig.settings.user.fullname; email = nixosConfig.settings.user.email; };
          commit.gpgSign = true;
          tag.gpgSign = true;
        };
      }
      # Work
      {
        condition = "gitdir:~/src/snowdog/";
        contents = {
          user = { name = nixosConfig.settings.user.fullname; email = "konrad.baran@snow.dog"; };
          commit.gpgSign = true;
          tag.gpgSign = true;
        };
      }
    ];
  };
}
