{
  lib,
  pkgs,
  addons,
}:
let
  cfg = addons.swaylock;

  name = "myswaylock";
  src = ./myswaylock.sh;

  myswaylock = lib.writeScript {
    inherit
      pkgs
      name
      cfg
      src
      ;
  };
in
lib.mkIf cfg.enable {
  home.packages = with pkgs; [
    myswaylock
    swaylock-effects
  ];
}
