{ lib, config, ... }:
let
  cfg = config.myypo.services.custom.min-brightness;
in
with lib;
{
  options.myypo.services.custom.min-brightness = {
    enable = mkEnableOption "minimum setable brightness service";

    minLevel = mkOption {
      type = types.int;
      default = 1;
    };
  };

  config = mkIf cfg.enable {
    # Prevents from setting laptop's screen brightness to 0, accidentally disabling it
    systemd.user.services.min-brightness = {
      description = "Set minimum brightness service";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "light -N ${builtins.toString cfg.minLevel}";
        Restart = "on-failure";
        RestartSec = 5;
      };
    };
  };
}
