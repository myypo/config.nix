{ lib, ... }:
with lib;
let
  userOpts = {
    options.image.common = {
      enableAll = mkEnableOption "enable all image viewers and manipulation tools";
    };
  };

  dirModules = lib.readDirModules ./.;
in
{
  options = lib.makeHomeOpts userOpts;

  imports = dirModules;
}
