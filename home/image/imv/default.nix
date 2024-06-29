{
  lib,
  pkgs,
  config,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "image";
    name = "imv";
  };

  userOpts = {
    options.image.imv = {
      enable = lib.mkNullableEnableOption "imv";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      userName: cfg:
        lib.mkIfFall cfg (import ./config.nix {
          inherit lib pkgs;

          isMainImageViewer = config.myypo.users.${userName}.mainImageViewer == "imv";
        })
    )
    cfgs;
}
