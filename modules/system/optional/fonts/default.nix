{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.myypo.fonts;
in {
  options.myypo.fonts.enable = mkEnableOption "fonts";

  config = mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = false;

      packages = with pkgs; [
        roboto # sans-serif
        cm_unicode # serif
        jetbrains-mono # mono

        noto-fonts-emoji
        twemoji-color-font

        nerdfonts

        noto-fonts
        noto-fonts-cjk
      ];
      fontconfig = {
        localConf = builtins.readFile ./localConf.xml;
      };
    };
  };
}
