{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.shells.bash = {
      enable = lib.makeNullableEnableOption "fish";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "shells";
    name = "bash";
  };
}
