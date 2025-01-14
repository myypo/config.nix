{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.myypo.programs.archiving;
in
{
  options.myypo.programs.archiving = {
    enable = mkEnableOption "archiving utils";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      p7zip

      atool

      unzip
      zip

      rar
    ];
  };
}
