{ lib, config, ... }:
with lib;
{
  options.myypo = {
    hostName = mkOption { type = types.str; };
  };

  config = {
    networking = {
      hostName = config.myypo.hostName;

      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
        wifi = {
          backend = "iwd";
        };
      };
    };

    services = {
      gnome.glib-networking.enable = true;
      resolved.enable = true;
    };
  };
}
