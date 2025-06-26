{
  lib,
  pkgs,
  size,
  theme,
}:
let
  themeAttrs = import ./themes/${theme} { inherit pkgs; };
in
(lib.attrsets.recursiveUpdate {
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    inherit size;
  };
  home.sessionVariables = {
    HYPRCURSOR_SIZE = size;
  };
} themeAttrs)
