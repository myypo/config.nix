{
  lib,
  config,
  pkgs,
  ...
}:
let
  userOpts = {
    options.office.latex = {
      enable = lib.makeNullableEnableOption "latex";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "office";
    name = "latex";
  };
}
