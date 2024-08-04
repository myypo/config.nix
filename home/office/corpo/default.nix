{
  lib,
  config,
  pkgs,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "office";
    name = "corpo";
  };

  userOpts = {
    options.other.corpo = {
      enable = lib.mkNullableEnableOption "corpo";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      _: cfg:
        lib.mkIfFall cfg {
          home = {
            packages = with pkgs; [
              slack
              postman
              buttercup-desktop
            ];
          };
        }
    )
    cfgs;
}
