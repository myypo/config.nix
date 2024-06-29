{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfgs = lib.getCfgs {
    inherit config;
    type = "shells";
    name = "fish";
  };

  userOpts = {
    options.shells.fish = {
      enable = lib.mkNullableEnableOption "fish";

      hostName = mkOption {
        type = types.str;
        default = config.myypo.hostName;
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
            inherit pkgs hostName;

            escalCmd = config.myypo.security.privilege-elevation.cmd;

            theme = lib.valueOrUserDefault {
              inherit config userName;
              name = "theme";
              val = theme;
            };

            flake_path = lib.getUserSecret {
              inherit config userName;
              secretName = "flake_path";
            };
          })
    )
    cfgs;
}
