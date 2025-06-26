{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.myypo.programs.term-utils;
in
{
  options.myypo.programs.term-utils = {
    enable = mkEnableOption "core terminal utils";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jq

      killall
    ];
  };
}
