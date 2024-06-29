{
  lib,
  pkgs,
  theme,
  isMainBrowser,
}: let
  xdgBrowser = "org.qutebrowser.qutebrowser.desktop";
in {
  home = {
    packages = with pkgs; [
      qutebrowser
      python311Packages.adblock
    ];

    # HACK: Have to assign these vars to prevent qutebrowser from crashing on file picker:
    # https://github.com/NixOS/nixpkgs/issues/168484
    sessionVariables.XDG_DATA_DIRS = with pkgs; lib.mkForce "$XDG_DATA_DIRS:${gtk3}/share/gsettings-schemas/gtk+3-${gtk3.version}:${gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas-${gsettings-desktop-schemas.version}";
  };

  home.file.".config/qutebrowser/config.py".source = ./settings/config.py;
  home.file.".config/qutebrowser/theme.py".source = ./settings/themes/${theme}.py;

  home.file.".config/qutebrowser/greasemonkey/yt-adblock.js".source = ./settings/greasemonkey/yt-adblock.js;
  home.file.".config/qutebrowser/greasemonkey/yt-shorts-blocker.js".source = ./settings/greasemonkey/yt-shorts-blocker.js;

  home.file.".config/qutebrowser/quickmarks".source = ./settings/quickmarks;

  xdg = lib.mkIf isMainBrowser (lib.setMainBrowser {inherit xdgBrowser;});
  home.sessionVariables.BROWSER = lib.mkIf isMainBrowser "qutebrowser";
}
