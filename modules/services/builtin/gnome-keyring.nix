{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.myypo.services.builtin.gnome-keyring;
in {
  options.myypo.services.builtin.gnome-keyring = {
    enable = mkEnableOption "gnome-keyring service";
  };

  config = mkIf cfg.enable {
    programs = {
      seahorse.enable = true;
    };

    services = {
      gnome.gnome-keyring.enable = true;
    };
  };
}
