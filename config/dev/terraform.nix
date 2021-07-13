{ pkgs, ... }:

with pkgs;
let
  terraformProviders = tfp: with tfp; [
    aws
    google
  ];
in
{
  home.packages = [
    (terraform_0_15.withPlugins terraformProviders)
  ];
}
