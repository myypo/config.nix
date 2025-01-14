{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.shells.shared = {
      enable = lib.makeNullableEnableOption "shared";

      theme = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
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
    name = "shared";
  };
}
