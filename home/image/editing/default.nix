{
  lib,
  pkgs,
  config,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "image";
    name = "editing";
  };

  userOpts = {
    options.image.editing = {
      enable = lib.mkNullableEnableOption "editing";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      userName: cfg:
        lib.mkIfFall cfg (import ./config.nix {
          inherit pkgs;
        })
    )
    cfgs;
}
