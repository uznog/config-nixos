{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.docker-compose ];

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      liveRestore = false;
    };

    containerd.enable = true;
  };
}
