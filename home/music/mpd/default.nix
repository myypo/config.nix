{
  lib,
  config,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "music";
    name = "mpd";
  };

  userOpts = {
    options.music.mpd = {
      enable = lib.mkNullableEnableOption "mpd";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      userName: cfg:
        lib.mkIfFall cfg (import ./config.nix {})
    )
    cfgs;
}
