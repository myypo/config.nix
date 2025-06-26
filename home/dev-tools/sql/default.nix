{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  userOpts = {
    options.dev-tools.sql = {
      enable = makeNullableEnableOption "sql dev-tools";
    };
  };
in
{
  options = makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "dev-tools";
    name = "sql";
  };
}
