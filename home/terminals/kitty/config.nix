{
  lib,
  pkgs,
  theme,
  fontSize,
  escalCmd,
  pagerCompatible,
  isMainTerminal,
}:
let
  cfg = { };

  mykitty = lib.writeScript {
    inherit pkgs cfg;
    name = "mykitty";
    src = ./scripts/kitty_unix_soc.sh;
  };
  kitty_nvim = lib.writeScript {
    inherit pkgs cfg;
    name = "v";
    src = ./scripts/kitty_nvim.sh;
  };
in
{
  home.sessionVariables = lib.mkIf isMainTerminal { TERMINAL = "kitty"; };
  home.packages = [
    mykitty

    # Convenient command to open nvim in kitty in cwd
    (if isMainTerminal then kitty_nvim else null)
  ];

  xdg.configFile."kitty/job_win.py".source = ./kittens/job_win.py;

  imports = [ (import ./themes/${theme} { inherit fontSize; }) ];

  programs = {
    kitty = {
      enable = true;

      keybindings = {
        # Make it possible to use ctrl+shift modifier for the following keys
        # by mapping them to their decimal representations https://www.asciitable.com/
        "ctrl+shift+," = "send_text application \\033[44;6u";
        "ctrl+shift+a" = "send_text application \\033[97;6u";
        "ctrl+shift+c" = "send_text application \\033[99;6u";
        "ctrl+shift+d" = "send_text application \\033[100;6u";
        "ctrl+shift+e" = "send_text application \\033[101;6u";
        "ctrl+shift+h" = "send_text application \\033[104;6u";
        "ctrl+shift+n" = "send_text application \\033[110;6u";
        "ctrl+shift+p" = "send_text application \\033[112;6u";
        "ctrl+shift+s" = "send_text application \\033[115;6u";
        "ctrl+shift+t" = "send_text application \\033[116;6u";
        "ctrl+shift+u" = "send_text application \\033[117;6u";

        # Open pager to take a look at the terminal output
        "alt+r" = "show_last_command_output";
        "alt+ctrl+r" = "show_scrollback";

        "alt+d" = "next_tab";
        "alt+u" = "previous_tab";
        "alt+q" = "close_window";

        "alt+w" = "kitten job_win.py";
      };

      settings = {
        bold_italic_font = "auto";
        italic_font = "auto";

        window_padding_width = 7;

        mouse_hide_wait = 2;
        copy_on_select = true;
        enable_audio_bell = false;
        allow_remote_control = true;
        update_check_interval = 0;
        tab_bar_style = "hidden";
        confirm_os_window_close = 0;

        enabled_layouts = "horizontal";

        scrollback_pager = lib.mkIf pagerCompatible "kitty_pager";

        shell_integration = lib.mkIf (escalCmd == "doas") "no-sudo";

        wayland_enable_ime = false;
      };
    };
  };
}
