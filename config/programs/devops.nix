{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ansible_2_9
    awscli2
    dbeaver
    dig
    google-cloud-sdk
    httpie
    oracle-instantclient
    terraform_0_15
    vagrant
    virt-manager
    virt-viewer
  ];
}
