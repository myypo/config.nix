{ lib, ... }:
with lib;
let
  userOpts = {
    options.browsers.common = {
      enableAll = mkEnableOption "enable all configured web-browsers";
    };
  };

  dirModules = lib.readDirModules ./.;
in
{
  options = lib.makeHomeOpts userOpts;

  imports = dirModules;
}
