{ lib, ... }:
let
  userOpts = {
    options.video.common = {
      enableAll = lib.mkEnableOption "enable all video players and editors";
    };
  };

  dirModules = lib.readDirModules ./.;
in
{
  options = lib.makeHomeOpts userOpts;

  imports = dirModules;
}
