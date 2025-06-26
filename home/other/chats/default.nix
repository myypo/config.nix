{
  lib,
  config,
  pkgs,
  ...
}:
let
  userOpts = {
    options.other.chats = {
      enable = lib.makeNullableEnableOption "chats";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "other";
    name = "chats";
  };
}
