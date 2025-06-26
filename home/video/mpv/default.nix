{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.video.mpv = {
      enable = lib.makeNullableEnableOption "mpv";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "video";
    name = "mpv";
    addArgsFn = userName: cfg: {
      isMainVideoPlayer = config.myypo.users.${userName}.mainVideoPlayer == "mpv";
    };
  };
}
