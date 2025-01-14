{ lib, ... }:
with lib;
let
  userOpts = {
    options.music.common = {
      enableAll = mkEnableOption "enable all music players and audio manipulation tools";
    };
  };

  dirModules = lib.readDirModules ./.;
in
{
  options = lib.makeHomeOpts userOpts;

  imports = dirModules;
}
