{
  lib,
  pkgs,
  addons,
}:
let
  cfg = addons.to_notif;

  name = "to_notif";
  src = ./to_notif.sh;

  to_notif = lib.writeScript {
    inherit
      pkgs
      name
      cfg
      src
      ;
  };
in
lib.mkIf cfg.enable { home.packages = [ to_notif ]; }
