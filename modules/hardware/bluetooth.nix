{ lib, config, ... }:
with lib;
let
  cfg = config.myypo.hardware.bluetooth;
in
{
  options.myypo.hardware.bluetooth = {
    enable = mkEnableOption "bluetooth";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    services.blueman.enable = true;
  };
}
