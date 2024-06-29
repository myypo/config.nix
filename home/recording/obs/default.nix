{
  lib,
  config,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "recording";
    name = "obs";
  };

  userOpts = {
    options.recording.obs = {
      enable = lib.mkNullableEnableOption "obs";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      _: cfg:
        lib.mkIfFall cfg (import ./config.nix {})
    )
    cfgs;
}
