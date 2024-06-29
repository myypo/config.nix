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
    name = "wf-recorder";
  };
  enable = lib.cfgIsEnabled {
    inherit config;
    type = "recording";
    name = "wf-recorder";
  };

  userOpts = {
    options.recording.wf-recorder = {
      enable = lib.mkNullableEnableOption "wf-recorder";
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
