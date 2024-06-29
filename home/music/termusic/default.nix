{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfgs = lib.getCfgs {
    inherit config;
    type = "music";
    name = "termusic";
  };

  userOpts = {
    options.music.termusic = {
      enable = lib.mkNullableEnableOption "termusic";

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

            theme = lib.valueOrUserDefault {
              inherit config userName;
              name = "theme";
              val = theme;
            };

            isMainMusicPlayer = config.myypo.users.${userName}.mainMusicPlayer == "termusic";
          })
    )
    cfgs;
}
