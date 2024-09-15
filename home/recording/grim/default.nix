{
  lib,
  inputs,
  config,
  pkgs,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "recording";
    name = "grim";
  };
  enable = lib.cfgIsEnabled {
    inherit config;
    type = "recording";
    name = "grim";
  };

  userOpts = {
    options.recording.grim = {
      enable = lib.mkNullableEnableOption "grim";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config = lib.mkIf enable {
    home-manager.users =
      builtins.mapAttrs (
        _: cfg:
          lib.mkIfFall cfg (import ./config.nix {
            inherit lib inputs pkgs;
          })
      )
      cfgs;
  };
}
