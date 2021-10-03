{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ansible_2_9
    awscli2
    dbeaver
    dig
    dive
    du-dust
    google-cloud-sdk
    httpie
    oracle-instantclient
    ripgrep
    ripgrep-all
    sshfs
    terraform_0_15
    vagrant
    virt-manager
    virt-viewer
  ];
}
