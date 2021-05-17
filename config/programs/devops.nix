{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ansible_2_9
    httpie
    vagrant
  ];
}
