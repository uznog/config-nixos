{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "Nord";
    };
  };

  home.packages = with pkgs; [
    bat-extras.batman
  ];
}
