{ lib, ... }:
with lib;
let
  userOpts = {
    options.notifications.common = {
      enable = mkEnableOption "enable notifications daemon";

      backend = mkOption {
        type = types.enum [ "mako" ];
        default = "mako";
      };

      fontSize = mkOption {
        type = types.nullOr types.int;
        default = null;
      };
      theme = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };

  dirModules = lib.readDirModules ./.;
in
{
  options = lib.makeHomeOpts userOpts;

  imports = dirModules;
}
