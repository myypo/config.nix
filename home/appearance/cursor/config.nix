{
  lib,
  pkgs,
  size,
  theme,
}: let
  themeAttrs = import ./themes/${theme} {inherit pkgs;};
in (lib.attrsets.recursiveUpdate {
    home.pointerCursor = {
      gtk.enable = true;

      inherit size;
    };
  }
  themeAttrs)
