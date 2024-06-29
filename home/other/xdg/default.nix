{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfgs = getCfgs {
    inherit config;
    type = "other";
    name = "xdg";
  };

  userOpts = {
    options.other.xdg = {
      enable = mkNullableEnableOption "xdg";
    };
  };
in {
  options = setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      _: cfg:
        mkIfFall cfg {
          home.packages = with pkgs; [
            xdg-utils
          ];

          xdg = {
            enable = true;

            mimeApps.enable = true;
          };
        }
    )
    cfgs;
}
