{ lib, config, ... }:
with lib;
let
  cfg = config.myypo.security.privilege-elevation;
in
{
  options.myypo.security.privilege-elevation = {
    cmd = mkOption {
      type = types.enum [
        "sudo"
        "doas"
      ];
      default = "sudo";
    };
  };

  config = mkIf (cfg.cmd == "doas") {
    security = {
      doas = {
        enable = true;
        wheelNeedsPassword = false;
      };

      polkit.enable = true;

      sudo.enable = mkForce false;
    };
  };
}
