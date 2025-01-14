{
  lib,
  pkgs,
  theme,
  fontSize,
  isMainTerminal,
}:
{
  home.sessionVariables = lib.mkIf isMainTerminal { TERMINAL = "wezterm"; };

  xdg.configFile."wezterm/colors/${theme}.toml".source = ./themes/${theme}.toml;

  programs = {
    wezterm = {
      enable = true;

      extraConfig = ''
        local wezterm = require 'wezterm'

        local config = wezterm.config_builder()

        config.font = wezterm.font_with_fallback({
            { family = "JetBrains Mono" },
            { family = "Noto Color Emoji" },
        })
        config.font_size = ${builtins.toString fontSize}
        config.front_end = "WebGpu"
        config.freetype_load_flags = "NO_HINTING"
        config.anti_alias_custom_block_glyphs = true
        config.unicode_version = 8

        config.enable_tab_bar = false

        config.cursor_blink_rate = 0
        config.audible_bell = "Disabled"

        config.window_decorations = "NONE"
        config.window_padding = {
          left = 5,
          right = 5,
          top = 0,
          bottom = 0,
        }

        config.color_scheme = "${theme}"

        return config
      '';
    };
  };
}
