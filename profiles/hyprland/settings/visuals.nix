{
  lib,
  theme,
  monitors,
  mainTerminalMeta,
}:
{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 0;
      gaps_out = 0;
      border_size = 3;
      "col.active_border" = theme.activeBorderColor;

      # Use master layout, where there is the main (bigger)
      # window always positioned on the left side
      layout = "master";
    };

    master = {
      new_status = "slave";

      # Size of non-master windows relative to master
      special_scale_factor = 0.8;
    };

    decoration = {
      # Make windows fully opaque by default
      # we apply transparency on particular windows instead
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      fullscreen_opacity = 1.0;

      rounding = 0;

      shadow.enabled = false;
      dim_inactive = false;

      blur = {
        enabled = false;
      };
    };

    animations = {
      enabled = true;
      # Here you can customize how animations will look
      # in addition to hyprland wiki there are many css resources
      # delving into bezier curve functions
      bezier = theme.bezier;

      # Animations for workspace switching and active window border switching
      # are disabled  because I don't like them
      animation = theme.animation;
    };

    cursor = {
      # Do not move cursor on active window change
      no_warps = true;
      persistent_warps = true;
      inactive_timeout = 5;
    };

    misc = {
      disable_autoreload = true;
      disable_hyprland_logo = true;

      # Swallow allows to replace the terminal from where we open a
      # GUI program with the program in question
      enable_swallow = true;
      swallow_regex = "^(${mainTerminalMeta.className})$";
    };

    monitor = lib.attrsets.mapAttrsToList (
      _: v:
      "${v.name},${v.settings},${v.position},${v.scaling}"
      + (if v.extra != null then ",${v.extra}" else "")
    ) monitors;
  };
}
