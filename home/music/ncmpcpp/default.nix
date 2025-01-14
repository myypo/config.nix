{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.music.ncmpcpp = {
      enable = lib.makeNullableEnableOption "ncmpcpp";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "music";
    name = "ncmpcpp";
    addArgsFn = userName: cfg: {
      isMainMusicPlayer = config.myypo.users.${userName}.mainMusicPlayer == "ncmpcpp";
    };
  };
}
