{ lib, ... }:
with lib;
let
  userOpts = {
    options.office.common = {
      enableAll = mkEnableOption "enable all configured office tools";
    };
  };

  dirModules = lib.readDirModules ./.;
in
{
  options = lib.makeHomeOpts userOpts;

  imports = dirModules;
}
