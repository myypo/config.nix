{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.myypo.services.custom.polkit-gnome;
in
with lib;
{
  options.myypo.services.custom.polkit-gnome = {
    enable = mkEnableOption "polkit gnome service";
  };

  config = mkIf cfg.enable {
    security.polkit.enable = true;

    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
