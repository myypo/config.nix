{
  lib,
  config,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "dev-tools";
    name = "direnv";
  };

  userOpts = {
    options.dev-tools.direnv = {
      enable = lib.mkNullableEnableOption "direnv";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      userName: cfg: lib.mkIfFall cfg (import ./config.nix {})
    )
    cfgs;
}
