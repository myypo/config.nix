{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  userOpts = {
    options.shells.fish = {
      enable = lib.makeNullableEnableOption "fish";

      hostName = mkOption {
        type = types.str;
        default = config.myypo.hostName;
      };

      theme = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "shells";
    name = "fish";
  };
}
