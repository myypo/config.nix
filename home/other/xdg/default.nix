{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  userOpts = {
    options.other.xdg = {
      enable = makeNullableEnableOption "xdg";
    };
  };
in {
  options = makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "other";
    name = "xdg";
  };
}
