{ pkgs, ... }:
let
  catpuccinName = "catppuccin-mocha-maroon-cursors";
in
{
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaMaroon;
    name = catpuccinName;
  };

  home.sessionVariables = {
    HYPRCURSOR_THEME = catpuccinName;
  };
}
