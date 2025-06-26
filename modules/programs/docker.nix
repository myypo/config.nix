{ lib, config, ... }:
with lib;
let
  cfg = config.myypo.programs.docker;
in
{
  options.myypo.programs.docker = {
    enable = mkEnableOption "whether to enable docker system-wide";

    members = mkOption { type = types.listOf types.str; };
  };

  config = mkIf cfg.enable {
    virtualisation = {
      docker.enable = true;
    };

    users.groups.docker.members = cfg.members;
  };
}
