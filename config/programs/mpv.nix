{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    syncplay
    youtube-dl
  ];

  programs.mpv = {
    enable = true;
    package = pkgs.wrapMpv (pkgs.mpv-unwrapped.override {
      vapoursynthSupport = true;
      vapoursynth = pkgs.vapoursynth.withPlugins (with pkgs; [
        vapoursynth-mvtools
      ]); 
    }) { youtubeSupport = false; };
  };

  xdg.configFile."mpv".source = ../dotfiles/mpv;
}
