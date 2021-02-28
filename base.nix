{ config, pkgs, ... }:

{
  imports = [
    nixos/configuration.nix
    /etc/nixos/hardware-configuration.nix
    modules/settings.nix
  ];

  settings = {
    username = "kbaran";
    fontName = "SauceCodePro Nerd Font";
    fontSize = 12;
    xkbFile = "none";
    terminal = "alacritty";
  };

  virtualisation.vmware.guest.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;


  # Used for file sharing between host and guest
  services.openssh.enable = true;
}
