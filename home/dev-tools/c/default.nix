{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  userOpts = {
    options.dev-tools.c = {
      enable = makeNullableEnableOption "c dev-tools";
    };
  };
in {
  options = makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "dev-tools";
    name = "c";
  };
}
