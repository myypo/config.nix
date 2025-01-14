{
  lib,
  inputs,
  pkgs,
}:
let
  cfg = { };

  wf_record_area = lib.writeScript {
    inherit pkgs cfg;
    name = "wf_record_area";
    src = ./scripts/wf_record_area.sh;
  };
  wf_record_screen = lib.writeScript {
    inherit pkgs cfg;
    name = "wf_record_screen";
    src = ./scripts/wf_record_screen.sh;
  };
in
{
  home.packages = with pkgs; [
    wf-recorder
    slurp

    wf_record_screen
    wf_record_area
  ];
}
