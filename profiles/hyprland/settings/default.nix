{
  lib,
  cfg,
  userCfg,
}:
let
  addons = cfg.addons;
  monitors = cfg.monitors;
  theme = import ./themes/${cfg.theme};

  mainTerminal = userCfg.mainTerminal;
  mainTerminalMeta = lib.getMeta "terminals" mainTerminal;

  mainShell = userCfg.mainShell;

  mainImageViewer = userCfg.mainImageViewer;
  mainImageViewerMeta = lib.getMeta "image" mainImageViewer;

  mainFileManager = userCfg.mainFileManager;
  mainFileManagerMeta = lib.getMeta "file-managers" mainFileManager;

  mainBrowser = userCfg.mainBrowser;
  mainBrowserMeta = lib.getMeta "browsers" mainBrowser;

  mainMusicPlayer = userCfg.mainMusicPlayer;
  mainMusicPlayerMeta = lib.getMeta "music" mainMusicPlayer;
in
{
  imports = [
    (import ./autostart.nix { inherit lib addons userCfg; })

    (import ./controls.nix {
      inherit
        lib
        addons
        userCfg
        mainTerminal
        mainTerminalMeta
        mainShell
        mainMusicPlayer
        ;
    })

    (import ./rules.nix {
      inherit
        mainBrowserMeta
        mainTerminalMeta
        mainImageViewerMeta
        mainFileManagerMeta
        mainMusicPlayerMeta
        ;
    })

    (import ./visuals.nix {
      inherit
        lib
        theme
        monitors
        mainTerminalMeta
        ;
    })
  ];
}
