{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfgs = getCfgs {
    inherit config;
    type = "shells";
    name = "bash";
  };

  userOpts = {
    options.shells.bash = {
      enable = mkNullableEnableOption "fish";
    };
  };
in {
  options = setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      _: cfg:
        mkIfFall cfg (import ./config.nix {inherit pkgs;})
    )
    cfgs;
}
