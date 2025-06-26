{
  lib,
  pkgs,
  addons,
}:
let
  cfg = addons.swww;
in
{
  imports = [ (import ./dynamic_wall { inherit lib pkgs addons; }) ];

  config = lib.mkIf cfg.enable {
    services.swww.enable = true;
  };
}
