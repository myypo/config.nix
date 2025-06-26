{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  userOpts = {
    options.other.cli-utils = {
      enable = lib.makeNullableEnableOption "misc cli tools";

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
    type = "other";
    name = "cli-utils";
  };
}
