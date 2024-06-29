{
  lib,
  config,
  ...
}: let
  gtkCfgs = lib.getCfgs {
    inherit config;
    type = "appearance";
    name = "wallpapers";
  };

  userOpts = {
    options.appearance = {
      wallpapers = {
        enable = lib.mkNullableEnableOption "wallpapers package";
      };
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      _: cfg:
        lib.mkIfFall cfg {
          home.file."Pictures/wallpapers".source = ./images;
        }
    )
    gtkCfgs;
}
