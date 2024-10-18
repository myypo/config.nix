{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfgs = lib.getCfgs {
    inherit config;
    type = "widgets";
    name = "rofi";
  };

  userOpts = {
    options.widgets.rofi = {
      enable = lib.mkNullableEnableOption "kitty";
    };
  };

  cfg = {};
  powermenu_theme = lib.writeScript {
    inherit pkgs cfg;
    name = "powermenu_theme";
    src = ./powermenu_theme.sh;
  };
  powermenu = lib.writeScript {
    inherit pkgs cfg;
    name = "powermenu";
    src = ./powermenu.sh;
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      _: cfg:
        lib.mkIfFall cfg {
          xdg.configFile."rofi/powermenu_theme.rasi".source = ./powermenu_theme.rasi;

          home.packages = with pkgs; [rofi-wayland powermenu_theme powermenu];
        }
    )
    cfgs;
}
