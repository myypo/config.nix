{
  lib,
  config,
  pkgs,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "office";
    name = "latex";
  };

  userOpts = {
    options.office.latex = {
      enable = lib.mkNullableEnableOption "latex";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      _: cfg:
        lib.mkIfFall cfg {
          home = {
            packages = with pkgs; [
              texlive.combined.scheme-full
              pandoc
            ];
          };
        }
    )
    cfgs;
}
