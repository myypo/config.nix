{
  lib,
  pkgs,
  addons,
}:
let
  cfg = addons.toggle_touchpad;

  disable_touchpad = lib.writeScript {
    inherit pkgs cfg;
    name = "disable_touchpad";
    src = ./disable_touchpad.sh;
  };
  enable_touchpad = lib.writeScript {
    inherit pkgs cfg;
    name = "enable_touchpad";
    src = ./enable_touchpad.sh;
  };
in
lib.mkIf cfg.enable {
  home.packages = [
    disable_touchpad
    enable_touchpad
  ];
}
