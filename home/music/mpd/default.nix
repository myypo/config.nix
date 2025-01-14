{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.music.mpd = {
      enable = lib.makeNullableEnableOption "mpd";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "music";
    name = "mpd";
  };
}
