{ config, pkgs, ... }:
{

  networking.networkmanager = {
    enableStrongSwan = true;
    packages = with pkgs; [
      networkmanager-l2tp
    ];
  };

  services.strongswan = {
    enable = true;
    secrets = [
      "ipsec.d/ipsec.nm-l2tp.secrets"
    ];
  };
}
