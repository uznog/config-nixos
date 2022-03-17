{ pkgs, inputs, ... }:

{
  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
    };
    package = pkgs.nix_2_4;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
    };
  };
}
