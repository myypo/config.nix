{
  lib,
  pkgs,
  addons,
}:
let
  cfg = addons.swww.dynamic_wall;

  name = "dynamic_wall";
  src = ./dynamic_wall.sh;

  dynamic_wall = lib.writeScript {
    inherit
      pkgs
      name
      cfg
      src
      ;
  };
in
lib.mkIf cfg.enable { home.packages = [ dynamic_wall ]; }
