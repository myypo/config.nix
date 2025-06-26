{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.other.gpg = {
      enable = lib.makeNullableEnableOption "gpg";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "other";
    name = "gpg";
  };
}
