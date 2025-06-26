{
  lib,
  isMainImageViewer,
}:
lib.makeImageViewer isMainImageViewer "imv.desktop" {
  programs.imv = {
    enable = true;
    settings = {
      binds = {
        q = "quit";
        r = "reset";

        "<Up>" = "pan 0 80";
        "<Down>" = "pan 0 -80";
        "<Left>" = "pan 80 0";
        "<Right>" = "pan -80 0";

        "+" = "zoom 2";
        "-" = "zoom -2";
      };
    };
  };
}
