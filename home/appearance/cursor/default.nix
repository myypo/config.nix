{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  userOpts = {
    options.appearance.cursor = {
      enable = lib.makeNullableEnableOption "custom cursor";

      size = mkOption { type = types.int; };
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
    type = "appearance";
    name = "cursor";
  };
}
