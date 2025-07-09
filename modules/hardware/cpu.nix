{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.myypo.hardware.cpu;

  boost = pkgs.writeShellScriptBin "boost" ''
    active_boost=$(cat /sys/devices/system/cpu/cpufreq/boost)

    if [ "$active_boost" -eq 1 ]; then
        if echo 0 | doas tee /sys/devices/system/cpu/cpufreq/boost &> /dev/null; then
            echo "CPU boost disabled"
        else
            echo "Failed to disable CPU boost. Are you running as root?"
            exit 1
        fi
    else
        if echo 1 | doas tee /sys/devices/system/cpu/cpufreq/boost &> /dev/null; then
            echo "CPU boost enabled"
        else
            echo "Failed to enable CPU boost. Are you running as root?"
            exit 1
        fi
    fi
  '';
in
{
  options.myypo.hardware.cpu = {
    enable = lib.mkEnableOption "enable custom cpu module";

    brand = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "intel"
          "amd"
          "other"
        ]
      );
      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      linux-firmware
      boost
    ];

    hardware = {
      # Enable all firmware regardless of license.
      enableAllFirmware = true;
      enableRedistributableFirmware = true;

      cpu.intel.updateMicrocode = lib.mkIf (cfg.brand == "intel") true;
      cpu.amd.updateMicrocode = lib.mkIf (cfg.brand == "amd") true;
    };
  };
}
