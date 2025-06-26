{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.dev-tools.ssh = {
      enable = lib.makeNullableEnableOption "ssh dev-tools";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "dev-tools";
    name = "ssh";
  };
}
