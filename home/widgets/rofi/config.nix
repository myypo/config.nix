{ pkgs }:
{
  xdg.configFile."rofi/powermenu_theme.rasi".source = ./powermenu_theme.rasi;

  home.packages = with pkgs; [
    rofi-wayland
    powermenu_theme
    powermenu
  ];
}
