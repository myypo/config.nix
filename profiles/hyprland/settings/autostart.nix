{
  lib,
  addons,
  userCfg,
}:
with lib;
{
  programs = {
    # Start hyprland automatically with fish
    fish = {
      loginShellInit = ''
        if uwsm check may-start
            exec uwsm start hyprland-uwsm.desktop
        end
      '';
    };
  };

  wayland.windowManager.hyprland = {
    settings = {
      ### Commands executed on startup ###
      exec-once = [
        "${userCfg.notifications.common.backend} &"

        (mkIf addons.swww.dynamic_wall.enable "dynamic_wall &")

        (mkIf addons.waybar.enable "waybar &")

        (mkIf addons.toggle_touchpad.enable "disable_touchpad &")
      ];
    };
  };
}
