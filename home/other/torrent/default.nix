{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.other.torrent = {
      enable = lib.makeNullableEnableOption "torrent";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "other";
    name = "torrent";
  };
}
