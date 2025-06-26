{ lib, config, ... }:
with lib;
let
  cfg = config.myypo.services.builtin.openssh;
in
{
  options.myypo.services.builtin.openssh = {
    enable = mkEnableOption "openssh";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        UseDns = true;
        X11Forwarding = false;
      };
    };
  };
}
