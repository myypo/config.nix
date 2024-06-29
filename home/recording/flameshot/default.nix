{
  lib,
  config,
  pkgs,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "recording";
    name = "flameshot";
  };
  enable = lib.cfgIsEnabled {
    inherit config;
    type = "recording";
    name = "flameshot";
  };

  userOpts = {
    options.recording.flameshot = {
      enable = lib.mkNullableEnableOption "flameshot";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config = lib.mkIf enable {
    home-manager.users =
      builtins.mapAttrs (
        _: cfg:
          lib.mkIfFall cfg {
            home.packages = with pkgs; [
              flameshot
            ];
          }
      )
      cfgs;

    nixpkgs.overlays = [
      (
        final: prev: {
          flameshot = prev.flameshot.overrideAttrs (old: {
            src = prev.fetchFromGitHub {
              owner = "flameshot-org";
              repo = "flameshot";
              rev = "3d21e49";
              hash = "sha256-OLRtF/yjHDN+sIbgilBZ6sBZ3FO6K533kFC1L2peugc=";
            };
            cmakeFlags = ["-DUSE_WAYLAND_GRIM=true"];
          });
        }
      )
    ];
  };
}
