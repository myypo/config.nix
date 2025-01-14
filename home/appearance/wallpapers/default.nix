{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.appearance = {
      wallpapers = {
        enable = lib.makeNullableEnableOption "wallpapers package";
      };
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "appearance";
    name = "wallpapers";
  };
}
