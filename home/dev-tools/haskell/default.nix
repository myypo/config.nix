{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfgs = getCfgs {
    inherit config;
    type = "dev-tools";
    name = "haskell";
  };

  userOpts = {
    options.dev-tools.haskell = {
      enable = mkNullableEnableOption "haskell dev-tools";
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
