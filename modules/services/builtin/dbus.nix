{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.myypo.services.builtin.dbus;
in
{
  options.myypo.services.builtin.dbus = {
    enable = mkEnableOption "dbus";
  };

  config = mkIf cfg.enable {
    services = {
      gvfs.enable = true;

      dbus = {
        enable = true;
        implementation = "broker";
        packages = with pkgs; [
          dconf
          gcr
          udisks2
        ];
      };
    };
  };
}
