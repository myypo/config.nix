{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.myypo.laptop-services;
in {
  options.myypo.laptop-services.enable = mkEnableOption "configuration for laptops";

  config = mkIf cfg.enable {
    programs.light.enable = true;

    services = {
      # Do NOT use tlp with auto-cpufreq: https://github.com/AdnanHodzic/auto-cpufreq/discussions/176
      # if laptop's battery life is the priority, switch to tlp entirely or do a research first
      auto-cpufreq.enable = true;

      thermald.enable = true;
    };
  };
}
