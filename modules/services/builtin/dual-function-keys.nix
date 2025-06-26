{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.myypo.services.builtin.dual-function-keys;
in
{
  options.myypo.services.builtin.dual-function-keys = {
    enable = mkEnableOption "dual function keys";
  };

  config = mkIf cfg.enable {
    environment.etc."dual-function-keys.yaml".text = ''
      TIMING:
        TAP_MILISEC: 50
        DOUBLE_TAP_MILLISEC: 0
      MAPPINGS:
        - KEY: KEY_CAPSLOCK
          TAP: KEY_ESC
          HOLD: KEY_LEFTCTRL
    '';

    services.interception-tools = {
      enable = true;
      plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
      udevmonConfig = ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/dual-function-keys.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [[KEY_CAPSLOCK, KEY_ESC]]
      '';
    };
  };
}
