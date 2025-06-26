{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.myypo.fonts;
in
{
  options.myypo.fonts.enable = mkEnableOption "fonts";

  config = mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = false;

      # TODO: this is kinda bad that all required fonts for the config are installed in one place
      # better to install fonts in the module where they are needed
      packages = with pkgs; [
        roboto # sans-serif
        cm_unicode # serif
        jetbrains-mono # mono

        noto-fonts-emoji
        twemoji-color-font

        nerd-fonts.jetbrains-mono
        nerd-fonts.daddy-time-mono
        nerd-fonts.symbols-only

        noto-fonts
        noto-fonts-cjk-sans
      ];
      fontconfig = {
        localConf = builtins.readFile ./localConf.xml;
      };
    };
  };
}
