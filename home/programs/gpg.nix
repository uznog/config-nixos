{ pkgs, ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    enableSshSupport = true;
    pinentryFlavor = "qt";
    extraConfig = ''
      write-env-file
      debug-level advanced
      keep-display
    '';
  };

}
