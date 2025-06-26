{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  userOpts = {
    options.shells.nushell = {
      enable = makeNullableEnableOption "nushell";

      theme = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };
in
{
  options = makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "shells";
    name = "nushell";
  };
}
