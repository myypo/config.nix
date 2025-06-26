{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  userOpts = {
    options.dev-tools.python = {
      enable = makeNullableEnableOption "python dev-tools";
    };
  };
in
{
  options = makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "dev-tools";
    name = "python";
  };
}
