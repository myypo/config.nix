{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.widgets.neofetch = {
      enable = lib.makeNullableEnableOption "neofetch";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "widgets";
    name = "neofetch";
  };
}
