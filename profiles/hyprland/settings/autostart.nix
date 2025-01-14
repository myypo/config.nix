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
        set TTY1 (tty)
        [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
      '';
    };
  };

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

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
