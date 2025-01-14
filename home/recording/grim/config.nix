{
  lib,
  inputs,
  pkgs,
}:
let
  cfg = { };

  grim_save_area = lib.writeScript {
    inherit pkgs cfg;
    name = "grim_save_area";
    src = ./scripts/grim_save_area.sh;
  };
  grim_save_screen = lib.writeScript {
    inherit pkgs cfg;
    name = "grim_save_screen";
    src = ./scripts/grim_save_screen.sh;
  };
in
{
  home.packages = with pkgs; [
    grim
    slurp
    satty

    grim_save_screen
    grim_save_area
  ];
}
