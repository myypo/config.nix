{
  lib,
  pkgs,
  isMainImageViewer,
}: let
  xdgImageViewer = "imv.desktop";
in {
  home.packages = with pkgs; [
    imv
  ];

  xdg = lib.mkIf isMainImageViewer (lib.setMainImageViewer {inherit xdgImageViewer;});
}
