{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfgs = lib.getCfgs {
    inherit config;
    type = "dev-tools";
    name = "github";
  };

  userOpts = {
    options.dev-tools.github = {
      enable = lib.mkNullableEnableOption "github";

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
