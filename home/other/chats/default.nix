{
  lib,
  config,
  pkgs,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "other";
    name = "chats";
  };

  userOpts = {
    options.other.chats = {
      enable = lib.mkNullableEnableOption "chats";
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
              tdesktop
            ];
          };
        }
    )
    cfgs;
}
