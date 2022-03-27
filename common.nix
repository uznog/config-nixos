{ pkgs, inputs, ... }:

{
  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
    };
    package = pkgs.nix_2_4;
    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
    };
  };
}
