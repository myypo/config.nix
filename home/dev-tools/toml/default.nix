{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.dev-tools.toml = {
      enable = lib.makeNullableEnableOption "toml dev-tools";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "dev-tools";
    name = "toml";
  };
}
