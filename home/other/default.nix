{ lib, ... }:
with lib;
let
  userOpts = {
    options.other.common = {
      enableAll = mkEnableOption "enable all not assorted modules";
    };
  };

  dirModules = lib.readDirModules ./.;
in
{
  options = lib.makeHomeOpts userOpts;

  imports = dirModules;
}
