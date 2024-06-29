{
  lib,
  pkgs,
  config,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "file-managers";
    name = "nemo";
  };

  userOpts = {
    options.file-managers.nemo = {
      enable = lib.mkNullableEnableOption "nemo";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      userName: cfg:
        lib.mkIfFall cfg (import ./config.nix {
          inherit lib pkgs;

          isMainFileManager = config.myypo.users.${userName}.mainFileManager == "nemo";
        })
    )
    cfgs;
}
