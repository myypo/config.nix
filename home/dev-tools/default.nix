{ lib, ... }:
with lib;
let
  userOpts = {
    options.dev-tools.common = {
      enableAll = mkEnableOption "enable all dev-tools";
    };
  };

  dirModules = lib.readDirModules ./.;
in
{
  options = lib.makeHomeOpts userOpts;

  imports = dirModules;
}
