{
  lib,
  pkgs,
  addons,
}:
let
  cfg = addons.waybar;
in
(lib.mkIf cfg.enable (import ./themes/${cfg.theme} { inherit pkgs; }))
