{
  pkgs,
  size,
  theme,
}: let
  themeAttrs =
    if theme == "mayu"
    then {
      package = pkgs.catppuccin-cursors.mochaMaroon;
      name = "catppuccin-mocha-maroon-cursors";
    }
    else abort "unsupported cursor theme specified: ${theme}";
in
  with themeAttrs; {
    home = {
      pointerCursor = {
        gtk.enable = true;

        inherit package;
        inherit name;

        inherit size;
      };
    };
  }
