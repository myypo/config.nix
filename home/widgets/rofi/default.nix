{
  lib,
  config,
  pkgs,
  ...
}:
let
  userOpts = {
    options.widgets.rofi = {
      enable = lib.makeNullableEnableOption "rofi";
    };
  };

  powermenu_theme = lib.writeScript {
    inherit pkgs;
    cfg = { };
    name = "powermenu_theme";
    src = ./powermenu_theme.sh;
  };
  powermenu = lib.writeScript {
    inherit pkgs;
    cfg = { };
    name = "powermenu";
    src = ./powermenu.sh;
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit config;
    pkgs = pkgs // {
      inherit powermenu_theme powermenu;
    };
    configPath = ./config.nix;
    type = "widgets";
    name = "rofi";
  };
}
