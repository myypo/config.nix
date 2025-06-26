{
  lib,
  config,
  pkgs,
  ...
}:
let
  userOpts = {
    options.other.corpo = {
      enable = lib.makeNullableEnableOption "corpo";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "office";
    name = "corpo";
  };
}
