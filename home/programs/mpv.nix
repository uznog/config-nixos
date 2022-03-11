{ pkgs, ... }:

{

  home.packages = with pkgs; [
    syncplay
    yt-dlp
  ];

  programs.mpv = {
    enable = true;
    package = pkgs.wrapMpv (pkgs.mpv-unwrapped.override {
      vapoursynthSupport = true;
      vapoursynth = pkgs.vapoursynth.withPlugins (with pkgs; [
        vapoursynth-mvtools
      ]); 
    }) {
      youtubeSupport = true;
      scripts = with pkgs; [
        mpvScripts.mpris
      ];
    };
  };
}
