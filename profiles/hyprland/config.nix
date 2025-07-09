{
  lib,
  cfg,
  inputs,
  pkgs,
  userCfg,
  flakePath,
}:
{
  imports = [
    (import ./addons {
      inherit
        lib
        pkgs
        cfg
        userCfg
        flakePath
        ;
    })
    (import ./scripts { inherit lib pkgs userCfg; })
    (import ./settings { inherit lib cfg userCfg; })
  ];

  home.packages = with pkgs; [
    hyprpicker
    grimblast

    playerctl

    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
  };
  xdg.configFile."hypr/xdph.conf".text = ''
    screencopy {
        allow_token_by_default = true
    }
  '';

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    SDL_VIDEO_DRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";

    # GBM_BACKEND = "nvidia-drm";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # LIBVA_DRIVER_NAME = "nvidia";

    CLUTTER_BACKEND = "wayland";

    # Not supported as of now https://github.com/hyprwm/Hyprland/issues/5996
    # WLR_RENDERER = "vulkan";

    # Deals with the bug that causes cursor to disappear on hyprland
    WLR_NO_HARDWARE_CURSORS = "1";

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };
}
