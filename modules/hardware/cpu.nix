{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.myypo.hardware.cpu;
in
{
  options.myypo.hardware.cpu = {
    enable = mkEnableOption "enable custom cpu module";

    brand = mkOption {
      type = types.nullOr (
        types.enum [
          "intel"
          "amd"
          "other"
        ]
      );
      default = null;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ linux-firmware ];

    hardware = with cfg; {
      # Enable all firmware regardless of license.
      enableAllFirmware = true;
      enableRedistributableFirmware = true;

      cpu.intel.updateMicrocode = mkIf (brand == "intel") true;
      cpu.amd.updateMicrocode = mkIf (brand == "amd") true;
    };
  };
}
