{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  userOpts = {
    options.appearance = {
      gtk = {
        enable = lib.makeNullableEnableOption "gtk";

        theme = mkOption {
          type = types.nullOr types.str;
          default = null;
        };

        fontSize = mkOption {
          type = types.nullOr types.int;
          default = null;
        };
      };
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "appearance";
    name = "gtk";
  };
}
