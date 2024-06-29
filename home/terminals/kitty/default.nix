{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfgs = lib.getCfgs {
    inherit config;
    type = "terminals";
    name = "kitty";
  };

  userOpts = {
    options.terminals.kitty = {
      enable = lib.mkNullableEnableOption "kitty";

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
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      userName: cfg:
        with cfg;
          lib.mkIfFall cfg (import ./config.nix {
            inherit lib pkgs;

            isMainTerminal = config.myypo.users.${userName}.mainTerminal == "kitty";

            escalCmd = config.myypo.security.privilege-elevation.cmd;

            fontSize = lib.valueOrUserDefault {
              inherit config userName;
              name = "fontSize";
              val = fontSize;
            };
            theme = lib.valueOrUserDefault {
              inherit config userName;
              name = "theme";
              val = theme;
            };

            pagerCompatible = let
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
            in (trivial.warnIfNot compat "Custom kitty pager is not compatible with the current configuration" compat);
          })
    )
    cfgs;
}
