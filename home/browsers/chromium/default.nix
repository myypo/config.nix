{
  lib,
  pkgs,
  config,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "browsers";
    name = "chromium";
  };

  userOpts = {
    options.browsers.chromium = {
      enable = lib.mkNullableEnableOption "chromium";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      userName: cfg:
        lib.mkIfFall cfg (import ./config.nix {
          inherit lib pkgs;
        })
    )
    cfgs;
}
