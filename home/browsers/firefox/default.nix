{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.browsers.firefox = {
      enable = lib.makeNullableEnableOption "firefox";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "browsers";
    name = "firefox";
    addArgsFn = userName: cfg: {
      isMainBrowser = config.myypo.users.${userName}.mainBrowser == "firefox";
    };
  };
}
