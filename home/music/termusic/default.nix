{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.music.termusic = {
      enable = lib.makeNullableEnableOption "termusic";

      theme = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "music";
    name = "termusic";
    addArgsFn = userName: cfg: {
      isMainMusicPlayer = config.myypo.users.${userName}.mainMusicPlayer == "termusic";
    };
  };
}
