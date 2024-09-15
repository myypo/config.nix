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
    name = "prose";
  };

  userOpts = {
    options.dev-tools.prose = {
      enable = mkNullableEnableOption "prose dev-tools";
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
