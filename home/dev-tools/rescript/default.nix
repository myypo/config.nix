{
  lib,
  inputs,
  pkgs,
  config,
  ...
}:
with lib; let
  cfgs = getCfgs {
    inherit config;
    type = "dev-tools";
    name = "rescript";
  };
  enable = cfgIsEnabled {
    inherit config;
    type = "dev-tools";
    name = "rescript";
  };

  userOpts = {
    options.dev-tools.rescript = {
      enable = mkNullableEnableOption "rescript dev-tools";
    };
  };
in {
  options = setSubOpts {inherit userOpts;};

  config = lib.mkIf enable {
    home-manager.users =
      builtins.mapAttrs (
        _: cfg:
          mkIfFall cfg (import ./config.nix {inherit inputs pkgs;})
      )
      cfgs;
  };
}
