{
  lib,
  inputs,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.widgets.sherlock = {
      enable = lib.makeNullableEnableOption "sherlock";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "widgets";
    name = "sherlock";
    addArgsFn = _: _: {
      inherit inputs;
    };
  };
}
