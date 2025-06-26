{
  lib,
  pkgs,
  addons,
}:
let
  cfg = addons.clamshell;

  name = "clamshell";
  src = ./clamshell.sh;

  clamshell = lib.writeScript {
    inherit
      pkgs
      name
      cfg
      src
      ;
  };
in
lib.mkIf cfg.enable { home.packages = [ clamshell ]; }
