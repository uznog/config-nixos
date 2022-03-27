{ pkgs, ... }:

{
  home.packages = with pkgs; [
    age
    ansible_2_9
    awscli2
    dbeaver
    dig
    dive
    du-dust
    gitkraken
    google-cloud-sdk
    helmsman
    httpie
    kind
    minio-client
    oracle-instantclient
    packer
    ripgrep
    ripgrep-all
    sops
    sshfs
    terraform_0_15
    vagrant
    vault
    virt-manager
    virt-viewer
  ];
}
