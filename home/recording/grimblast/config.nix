{
  lib,
  inputs,
  pkgs,
}:
let
  cfg = { };

  grimblast_save_area = lib.writeScript {
    inherit pkgs cfg;
    name = "grimblast_save_area";
    src = ./scripts/grimblast_save_area.sh;
  };
  grimblast_save_screen = lib.writeScript {
    inherit pkgs cfg;
    name = "grimblast_save_screen";
    src = ./scripts/grimblast_save_screen.sh;
  };
in
{
  home.packages = with pkgs; [
    grimblast
    slurp

    grimblast_save_screen
    grimblast_save_area
  ];
}
