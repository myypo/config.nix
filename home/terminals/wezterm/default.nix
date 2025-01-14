{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.terminals.wezterm = {
      enable = lib.makeNullableEnableOption "wezterm";

      fontSize = lib.mkOption {
        type = lib.types.nullOr lib.types.int;
        default = null;
      };
      theme = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "terminals";
    name = "wezterm";
    addArgsFn = userName: cfg: {
      isMainTerminal = config.myypo.users.${userName}.mainTerminal == "wezterm";
    };
  };
}
