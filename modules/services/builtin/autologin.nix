{ lib, config, ... }:
with lib;
let
  cfg = config.myypo.services.builtin.autologin;
in
{
  options.myypo.services.builtin.autologin = {
    enable = mkEnableOption "autologin";

    userName = mkOption { type = types.str; };
  };

  config = mkIf cfg.enable { services.getty.autologinUser = "${cfg.userName}"; };
}
