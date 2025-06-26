{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  userOpts = {
    options.other.wine = {
      enable = makeNullableEnableOption "wine";
    };
  };
in
{
  options = makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "other";
    name = "wine";
  };
}
