{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.dev-tools.rescript = {
      enable = lib.makeNullableEnableOption "rescript dev-tools";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "dev-tools";
    name = "rescript";
  };
}
