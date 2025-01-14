{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  userOpts = {
    options.dev-tools.lua = {
      enable = makeNullableEnableOption "lua dev-tools";
    };
  };
in
{
  options = makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "dev-tools";
    name = "lua";
  };
}
