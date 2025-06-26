{ lib, config, ... }:
with lib;
let
  cfg = config.myypo.hardware.ssd;
in
{
  options.myypo.hardware.ssd = {
    enable = mkEnableOption "ssd";
  };

  config = mkIf cfg.enable {
    services = {
      fstrim.enable = true;
    };
  };
}
