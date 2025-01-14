{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.browsers.chromium = {
      enable = lib.makeNullableEnableOption "chromium";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "browsers";
    name = "chromium";
  };
}
