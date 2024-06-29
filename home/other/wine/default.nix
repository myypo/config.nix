{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfgs = getCfgs {
    inherit config;
    type = "other";
    name = "wine";
  };

  userOpts = {
    options.other.wine = {
      enable = mkNullableEnableOption "wine";
    };
  };
in {
  options = setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      _: cfg:
        mkIfFall cfg {
          home = {
            packages = with pkgs; [
              wineWowPackages.waylandFull
              samba
              winetricks
            ];
          };
        }
    )
    cfgs;
}
