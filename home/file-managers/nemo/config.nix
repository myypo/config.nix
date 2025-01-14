{
  lib,
  pkgs,
  isMainFileManager,
}:
let
  xdgFileManager = "nemo.desktop";

  associations = {
    "inode/directory" = xdgFileManager;
  };
in
{
  home.packages = with pkgs; [ nemo ];

  xdg.mimeApps = lib.mkIf isMainFileManager {
    defaultApplications = associations;
    associations.added = associations;
  };
}
