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
    name = "wezterm";
  };

  userOpts = {
    options.terminals.wezterm = {
      enable = lib.mkNullableEnableOption "wezterm";

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

            isMainTerminal = config.myypo.users.${userName}.mainTerminal == "wezterm";
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
          })
    )
    cfgs;
}
