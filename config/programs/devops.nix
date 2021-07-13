{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ansible_2_9
    dbeaver
    dig
    httpie
    oracle-instantclient
    terraform_0_15
    vagrant
    virt-manager
    virt-viewer
  ];
}
