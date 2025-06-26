{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  userOpts = {
    options.terminals.kitty = {
      enable = lib.makeNullableEnableOption "kitty";

      fontSize = mkOption {
        type = types.nullOr types.int;
        default = null;
      };
      theme = mkOption {
        type = types.nullOr types.str;
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
    name = "kitty";
    addArgsFn = userName: cfg: {
      isMainTerminal = config.myypo.users.${userName}.mainTerminal == "kitty";

      pagerCompatible =
        let
          userCfg = config.myypo.users.${userName};

          fishEnabled = lib.userCfgIsEnabled {
            inherit userCfg;
            type = "shells";
            name = "fish";
          };
          nvimEnabled = lib.userCfgIsEnabled {
            inherit userCfg;
            type = "editors";
            name = "nvim";
          };

          compat = fishEnabled && nvimEnabled;
        in
        (trivial.warnIfNot compat "Custom kitty pager is not compatible with the current configuration"
          compat
        );
    };
  };
}
