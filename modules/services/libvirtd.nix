{ config, pkgs, pinned-pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    package = pinned-pkgs.libvirt;

    qemu = {
      runAsRoot = false;
      ovmf = {
        enable = true;
        package = pkgs.OVMFFull;
      };
    };

  };
}
