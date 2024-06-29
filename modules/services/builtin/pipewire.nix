{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.myypo.services.builtin.pipewire;
in {
  options.myypo.services.builtin.pipewire = {
    enable = mkEnableOption "pipewire";
  };

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = mkForce false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      audio.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pulsemixer
    ];
  };
}
