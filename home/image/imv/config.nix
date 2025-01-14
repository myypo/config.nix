{
  lib,
  pkgs,
  isMainImageViewer,
}:
lib.makeImageViewer isMainImageViewer "imv.desktop" { home.packages = with pkgs; [ imv ]; }
