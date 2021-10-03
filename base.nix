{ config, ... }:

{
  imports = [
    ./nixos/configuration.nix
    ./nixos/hardware-configuration.nix
    ./modules/settings.nix
  ];

  nixpkgs.config = import ./nixpkgs.nix;

  settings = {
    username = "kbaran";
    fontName = "SauceCodePro Nerd Font";
    fontSize = 12;
    kbLayout = "pl";
    xkbFile = "none";
    terminal = "alacritty";
  };
}
