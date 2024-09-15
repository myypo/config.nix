{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfgs = getCfgs {
    inherit config;
    type = "shells";
    name = "shared";
  };

  userOpts = {
    options.shells.shared = {
      enable = mkNullableEnableOption "shared";

      theme = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };
in {
  options = setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      userName: cfg:
        mkIfFall cfg (import ./config.nix {
          inherit lib pkgs;

          hostName = config.myypo.hostName;
          escalCmd = config.myypo.security.privilege-elevation.cmd;
          theme = lib.valueOrUserDefault {
            inherit config userName;
            name = "theme";
            val = cfg.theme;
          };
          flake_path = lib.getUserSecret {
            inherit config userName;
            secretName = "flake_path";
          };
        })
    )
    cfgs;
}
