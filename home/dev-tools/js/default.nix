{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  userOpts = {
    options.dev-tools.js = {
      enable = makeNullableEnableOption "js dev-tools";
    };
  };
in
{
  options = makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "dev-tools";
    name = "js";
  };
}
