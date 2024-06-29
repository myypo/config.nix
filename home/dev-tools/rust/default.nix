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
    name = "rust";
  };
  enable = cfgIsEnabled {
    inherit config;
    type = "dev-tools";
    name = "rust";
  };

  userOpts = {
    options.dev-tools.rust = {
      enable = mkNullableEnableOption "rust dev-tools";
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

    nixpkgs.overlays = [inputs.fenix.overlays.default];
  };
}
