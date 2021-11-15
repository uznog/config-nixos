{ pkgs, ... }:

{
  nix = {
    trustedUsers = [ "root" "@wheel" ];
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    tarball-ttl = 604800;
  };
}
