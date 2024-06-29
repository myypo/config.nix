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
    name = "cursor";
  };

  userOpts = {
    options.appearance.cursor = {
      enable = lib.mkNullableEnableOption "custom cursor";

      size = mkOption {
        type = types.int;
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
            inherit pkgs size;

            theme = lib.valueOrUserDefault {
              inherit config userName;
              name = "theme";
              val = theme;
            };
          })
    )
    gtkCfgs;
}
