{
  lib,
  pkgs,
  config,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "other";
    name = "gpg";
  };

  userOpts = {
    options.other.gpg = {
      enable = lib.mkNullableEnableOption "gpg";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      _: cfg:
        lib.mkIfFall cfg (import ./config.nix {inherit pkgs;})
    )
    cfgs;
}
