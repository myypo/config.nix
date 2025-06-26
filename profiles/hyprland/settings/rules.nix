{
  mainBrowserMeta,
  mainTerminalMeta,
  mainImageViewerMeta,
  mainFileManagerMeta,
  mainMusicPlayerMeta,
}:
{
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    # Generic terminal, transparent unless in fullscreen
    "opacity 0.92 override 0.92 override 1.0 override,class:^(${mainTerminalMeta.className})$"
    "animation slide right,class:^(${mainTerminalMeta.className})$"

    # Browser
    "workspace name:B,class:^(${mainBrowserMeta.className})$"

    # Telegram
    "workspace name:T,title:^(Telegram)$"

    # Slack
    "workspace name:S,class:^(Slack)$"

    # Music player
    "workspace name:M,class:^(${mainMusicPlayerMeta.className})$"
    "opacity 0.92,class:^(${mainMusicPlayerMeta.className})$"

    # Terminal-based project-chooser
    "float,class:^(project_management_float)$"
    "center,class:^(project_management_float)$"
    "size 35% 50%,class:^(project_management_float)$"
    "rounding 5,class:^(project_management_float)$"

    # Imave viewer
    "float,class:^(${mainImageViewerMeta.className})$"
    "fullscreen,class:^(${mainImageViewerMeta.className})$"

    # Fixes media stuttering in apps like tdesktop
    "float,title:^(Media viewer)$"
    "float,title:^(Picture-in-Picture)$"
  ];
}
