{ config, pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";

    qemu = {
      runAsRoot = false;
      ovmf = {
        enable = true;
        package = pkgs.OVMFFull;
      };
    };

  };
}
