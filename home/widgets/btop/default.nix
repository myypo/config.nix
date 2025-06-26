{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.widgets.btop = {
      enable = lib.makeNullableEnableOption "btop";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "widgets";
    name = "btop";
  };
}
