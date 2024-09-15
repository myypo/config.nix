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
    name = "nushell";
  };

  userOpts = {
    options.dev-tools.nushell = {
      enable = mkNullableEnableOption "nushell dev-tools";
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
