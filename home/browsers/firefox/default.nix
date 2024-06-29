{
  lib,
  pkgs,
  config,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "browsers";
    name = "firefox";
  };

  userOpts = {
    options.browsers.firefox = {
      enable = lib.mkNullableEnableOption "firefox";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      userName: cfg:
        lib.mkIfFall cfg (import ./config.nix {
          inherit lib pkgs;

          isMainBrowser = config.myypo.users.${userName}.mainBrowser == "firefox";
        })
    )
    cfgs;
}
