{ lib, ... }:
let
  userOpts = {
    options.widgets.common = {
      enableAll = lib.mkEnableOption "enable all configured widget apps";
    };
  };

  dirModules = lib.readDirModules ./.;
in
{
  options = lib.makeHomeOpts userOpts;

  imports = dirModules;
}
