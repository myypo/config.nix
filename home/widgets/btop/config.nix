{ theme }:
{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = theme;
    };
  };

  xdg.configFile."btop/themes/${theme}.theme".source = ./themes/${theme}.theme;
}
