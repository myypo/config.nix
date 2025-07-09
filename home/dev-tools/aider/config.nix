{
  lib,
  pkgs,
  flakePath,
}:
let
  mkOutOfStoreSymlink = lib.makeOutOfStore pkgs;
  baseSrcPath = "${flakePath}/home/dev-tools/aider";
in
{
  home.packages = with pkgs; [
    aider-chat
    playwright
  ];

  home.file.".aider.conf.yml".source = mkOutOfStoreSymlink "${baseSrcPath}/aider.conf.yml";
}
