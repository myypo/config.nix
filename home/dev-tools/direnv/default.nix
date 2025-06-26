{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.dev-tools.direnv = {
      enable = lib.makeNullableEnableOption "direnv";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "dev-tools";
    name = "direnv";
  };
}
