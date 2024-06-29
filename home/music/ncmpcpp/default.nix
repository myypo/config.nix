{
  lib,
  pkgs,
  config,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "music";
    name = "ncmpcpp";
  };

  userOpts = {
    options.music.ncmpcpp = {
      enable = lib.mkNullableEnableOption "ncmpcpp";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      userName: cfg:
        lib.mkIfFall cfg (import ./config.nix {
          inherit lib pkgs;

          isMainMusicPlayer = config.myypo.users.${userName}.mainMusicPlayer == "ncmpcpp";
        })
    )
    cfgs;
}
