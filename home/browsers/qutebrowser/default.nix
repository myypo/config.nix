{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfgs = lib.getCfgs {
    inherit config;
    type = "browsers";
    name = "qutebrowser";
  };

  userOpts = {
    options.browsers.qutebrowser = {
      enable = lib.mkNullableEnableOption "qutebrowser";

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

            isMainBrowser = config.myypo.users.${userName}.mainBrowser == "qutebrowser";

            theme = lib.valueOrUserDefault {
              inherit config userName;
              name = "theme";
              val = theme;
            };
          })
    )
    cfgs;
}
