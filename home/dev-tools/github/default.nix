{
  lib,
  config,
  pkgs,
  ...
}:
let
  userOpts = {
    options.dev-tools.github = {
      enable = lib.makeNullableEnableOption "github";

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
    type = "dev-tools";
    name = "github";
  };
}
