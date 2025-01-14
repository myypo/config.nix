{
  lib,
  pkgs,
  addons,
}:
let
  cfg = addons.swww;
in
{
  imports = [ (import ./dynamic_wall { inherit lib pkgs addons; }) ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ swww ];

    systemd.user.services = {
      swww = {
        Unit = {
          Description = "Start swww daemon";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Install.WantedBy = [ "graphical-session.target" ];
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.swww}/bin/swww-daemon";
          ExecStop = "${pkgs.swww}/bin/swww kill";
          Restart = "on-failure";
        };
      };
    };
  };
}
