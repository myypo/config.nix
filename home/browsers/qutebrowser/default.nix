{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  userOpts = {
    options.browsers.qutebrowser = {
      enable = lib.makeNullableEnableOption "qutebrowser";

      theme = mkOption {
        type = types.nullOr types.str;
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
    type = "browsers";
    name = "qutebrowser";
    addArgsFn = userName: cfg: {
      isMainBrowser = config.myypo.users.${userName}.mainBrowser == "qutebrowser";
    };
  };
}
