{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  gtkCfgs = lib.getCfgs {
    inherit config;
    type = "appearance";
    name = "gtk";
  };

  userOpts = {
    options.appearance = {
      gtk = {
        enable = lib.mkNullableEnableOption "gtk";

        theme = mkOption {
          type = types.nullOr types.str;
          default = null;
        };

        fontSize = mkOption {
          type = types.nullOr types.int;
          default = null;
        };
      };
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      userName: cfg:
        lib.mkIfFall cfg (import ./config.nix {
          inherit pkgs;

          theme = lib.valueOrUserDefault {
            inherit config userName;
            name = "theme";
            val = cfg.theme;
          };

          fontSize = lib.valueOrUserDefault {
            inherit config userName;
            name = "fontSize";
            val = cfg.fontSize;
          };
        })
    )
    gtkCfgs;
}
