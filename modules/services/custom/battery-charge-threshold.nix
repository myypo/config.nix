{ lib, config, ... }:
with lib;
let
  cfg = config.myypo.services.custom.battery-charge-threshold;
in
{
  options.myypo.services.custom = {
    battery-charge-threshold = {
      enable = mkEnableOption "laptop battery charge threshold";
      batteryName = mkOption { type = types.str; };
      maxChargeLevel = mkOption {
        type = types.int;
        default = 50;
      };
    };
  };
  config = mkIf cfg.enable {
    # Limit the maximum charge of the battery to extend its life
    systemd.services.battery-charge-threshold = {
      description = "Set the maximum battery charge level";
      wantedBy = [ "multi-user.target" ];
      after = [ "local-fs.target" ];
      serviceConfig = {
        StartLimitBurst = "0";
        Type = "oneshot";
        # The batName depends on the laptop model
        ExecStart = "/bin/sh -c 'echo ${builtins.toString cfg.maxChargeLevel} > /sys/class/power_supply/${cfg.batteryName}/charge_control_end_threshold'";
        User = "root";
        Restart = "on-failure";
      };
    };
  };
}
