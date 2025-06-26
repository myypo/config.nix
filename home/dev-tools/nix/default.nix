{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  userOpts = {
    options.dev-tools.nix = {
      enable = makeNullableEnableOption "nix dev-tools";
    };
  };
in
{
  options = makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "dev-tools";
    name = "nix";
  };
}
