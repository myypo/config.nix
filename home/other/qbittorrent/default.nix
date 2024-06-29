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
    name = "qbittorrent";
  };

  userOpts = {
    options.other.qbittorrent = {
      enable = mkNullableEnableOption "qbittorrent";
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
              qbittorrent
            ];
          };
        }
    )
    cfgs;
}
