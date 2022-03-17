{ config, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      liveRestore = false;
    };

    containerd.enable = true;
  };
}
