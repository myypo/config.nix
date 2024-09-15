{
  lib,
  config,
  pkgs,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "dev-tools";
    name = "github";
  };

  userOpts = {
    options.dev-tools.github = {
      enable = lib.mkNullableEnableOption "github";

      theme = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
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
            inherit pkgs;

            theme = lib.valueOrUserDefault {
              inherit config userName;
              name = "theme";
              val = theme;
            };
          })
    )
    cfgs;
}
