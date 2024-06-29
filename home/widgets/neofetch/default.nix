{
  lib,
  pkgs,
  config,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "widgets";
    name = "neofetch";
  };

  userOpts = {
    options.widgets.neofetch = {
      enable = lib.mkNullableEnableOption "kitty";
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
