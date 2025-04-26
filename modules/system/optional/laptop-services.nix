{ lib, config, ... }:
with lib;
let
  cfg = config.myypo.laptop-services;
in
{
  options.myypo.laptop-services = {
    enable = mkEnableOption "configuration for laptops";

    disableNvidia = mkEnableOption "whether to disable dedicated nvidia gpu on the laptop";
  };

  config = mkIf cfg.enable {
    programs.light.enable = true;

    services = {
      # Do NOT use tlp with auto-cpufreq: https://github.com/AdnanHodzic/auto-cpufreq/discussions/176
      # if laptop's battery life is the priority, switch to tlp entirely or do a research first
      auto-cpufreq = {
        enable = true;
        settings = {
          battery = {
            governor = "powersave";
            turbo = "never";
            energy_performance_preference = "power";
          };
          charger = {
            governor = "performance";
            turbo = "auto";
            energy_performance_preference = "performance";
          };
        };
      };

      thermald.enable = true;
    };

    services.udev.extraRules = mkIf cfg.disableNvidia ''
      # Remove NVIDIA USB xHCI Host Controller devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA USB Type-C UCSI devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA Audio devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA VGA/3D controller devices
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
    '';
    boot = mkIf cfg.disableNvidia {
      extraModprobeConfig = ''
        blacklist nouveau
        options nouveau modeset=0
      '';
      blacklistedKernelModules = [
        "nouveau"
        "nvidia"
        "nvidia_drm"
        "nvidia_modeset"
      ];
    };
  };
}
