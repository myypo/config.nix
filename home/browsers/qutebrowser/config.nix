{
  lib,
  pkgs,
  theme,
  isMainBrowser,
}:
lib.makeBrowser isMainBrowser "org.qutebrowser.qutebrowser.desktop" {
  home = {
    packages = with pkgs; [
      qutebrowser
      python311Packages.adblock
    ];

    # HACK: Have to assign these vars to prevent qutebrowser from crashing on file picker:
    # https://github.com/NixOS/nixpkgs/issues/168484
    sessionVariables.XDG_DATA_DIRS =
      with pkgs;
      lib.mkForce "$XDG_DATA_DIRS:${gtk3}/share/gsettings-schemas/gtk+3-${gtk3.version}:${gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas-${gsettings-desktop-schemas.version}";
  };

  xdg.configFile."qutebrowser/config.py".source = ./settings/config.py;
  xdg.configFile."qutebrowser/theme.py".source = ./settings/themes/${theme}.py;

  xdg.configFile."qutebrowser/greasemonkey/yt-adblock.js".source =
    ./settings/greasemonkey/yt-adblock.js;
  xdg.configFile."qutebrowser/greasemonkey/yt-shorts-blocker.js".source =
    ./settings/greasemonkey/yt-shorts-blocker.js;

  xdg.configFile."qutebrowser/quickmarks".source = ./settings/quickmarks;

  home.sessionVariables.BROWSER = lib.mkIf isMainBrowser "qutebrowser";
}
