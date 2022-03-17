{ config, ... }:

{
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";

  sops.secrets.hosts = { 
    format = "binary";
    sopsFile = ../secrets/hosts;
    path = "/etc/hosts";
    mode = "0444";
  };
}
