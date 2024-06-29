{
  lib,
  pkgs,
  config,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "video";
    name = "mpv";
  };

  userOpts = {
    options.video.mpv = {
      enable = lib.mkNullableEnableOption "mpv";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      userName: cfg:
        lib.mkIfFall cfg (import ./config.nix {
          inherit lib pkgs;

          isMainVideoPlayer = config.myypo.users.${userName}.mainVideoPlayer == "mpv";
        })
    )
    cfgs;
}
