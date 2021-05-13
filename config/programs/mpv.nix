{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    youtube-dl
    syncplay
  ];

  programs.mpv = {
    enable = true;
    package = pkgs.wrapMpv (pkgs.mpv-unwrapped.override {
      vapoursynthSupport = true; 
      vapoursynth = pkgs.vapoursynth.withPlugins (with pkgs; [
        vapoursynth-mvtools
      ]);
    }) { youtubeSupport = true; };
  };

  xdg.configFile."mpv".source = ../dotfiles/mpv;
}
