{ lib, config, ... }:
with lib;
let
  cfg = config.myypo.ukr-locale;
in
{
  options.myypo.ukr-locale.enable = mkEnableOption "Ukrainian locale";

  config = mkIf cfg.enable {
    time = {
      timeZone = "Europe/Kyiv";
    };

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "uk_UA.UTF-8/UTF-8"
    ];
  };
}
