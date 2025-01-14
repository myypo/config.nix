{
  lib,
  pkgs,
  cfg,
  userCfg,
}:
let
  addons = cfg.addons;
in
{
  imports = [
    (import ./clamshell { inherit lib pkgs addons; })
    (import ./project_management {
      inherit
        lib
        pkgs
        userCfg
        addons
        ;
    })
    (import ./swaylock { inherit lib pkgs addons; })
    (import ./swww { inherit lib pkgs addons; })
    (import ./toggle_touchpad { inherit lib pkgs addons; })
    (import ./to_notif { inherit lib pkgs addons; })
    (import ./waybar { inherit lib pkgs addons; })
  ];
}
