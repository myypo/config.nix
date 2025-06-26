{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.image.editing = {
      enable = lib.makeNullableEnableOption "editing";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "image";
    name = "editing";
  };
}
