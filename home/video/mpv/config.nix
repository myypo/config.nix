{
  lib,
  pkgs,
  isMainVideoPlayer,
}:
lib.makeVideoPlayer isMainVideoPlayer "mpv.desktop" {
  home.packages = with pkgs; [ ffmpegthumbnailer ];

  programs.mpv = {
    enable = true;
    config = {
      gpu-api = "vulkan";
      vo = "gpu";
      hwdec-codecs = "all";
    };
  };
}
