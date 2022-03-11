{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR --mouse --wheel-lines=3";
      theme = "Nord";
    };
  };

  home.packages = with pkgs; [
    bat-extras.batman
    less
  ];
}
