{ fontSize, ... }:
{
  xdg.configFile."kitty/themes/Mayu.conf".source = ./Mayu.conf;

  programs = {
    kitty = {
      font.name = "jetbrains mono nerd font";
      font.size = fontSize;
      extraConfig = ''
        include ~/.config/kitty/themes/Mayu.conf
        modify_font underline_position 2
      '';
      settings = {
        active_border_color = "#eba4ac";
        inactive_border_color = "#eba4ac";
        window_border_width = "1.5pt";

        cursor_shape = "beam";
        cursor_blink_interval = 0;

        url_color = "#0087bd";
        url_style = "dotted";
      };
    };
  };
}
