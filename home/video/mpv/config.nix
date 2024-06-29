{
  lib,
  pkgs,
  isMainVideoPlayer,
}: let
  xdgVideoPlayer = "mpv.desktop";
in {
  home.packages = with pkgs; [
    ffmpegthumbnailer
  ];

  programs.mpv = {
    enable = true;
    config = {
      gpu-api = "vulkan";
      vo = "gpu";
      hwdec-codecs = "all";
    };
  };

  xdg = lib.mkIf isMainVideoPlayer (lib.setMainVideoPlayer {inherit xdgVideoPlayer;});
}
