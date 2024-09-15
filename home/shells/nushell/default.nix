{
  lib,
  config,
  ...
}:
with lib; let
  cfgs = getCfgs {
    inherit config;
    type = "shells";
    name = "nushell";
  };

  userOpts = {
    options.shells.nushell = {
      enable = mkNullableEnableOption "nushell";

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
          inherit lib;

          theme = lib.valueOrUserDefault {
            inherit config userName;
            name = "theme";
            val = cfg.theme;
          };
        })
    )
    cfgs;
}
