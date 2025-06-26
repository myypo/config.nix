{
  lib,
  addons,
  userCfg,
  mainTerminal,
  mainTerminalMeta,
  mainShell,
  mainMusicPlayer,
}:
{
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";

      input = {
        kb_layout = "us,ua";
        kb_options = "grp:alts_toggle";

        follow_mouse = 2;
        float_switch_override_focus = 2;
        sensitivity = 0;
      };

      bindl = builtins.concatLists [
        (
          if addons.clamshell.enable then
            [
              # Laptop lid is opened
              ",switch:off:Lid Switch,exec,clamshell open"
              # Lid is closed
              ",switch:on:Lid Switch,exec,clamshell close"
            ]
          else
            [ ]
        )
      ];

      binds = {
        # Prevents from going back in history further than one workspace on workspace,previous
        allow_workspace_cycles = true;
      };

      bind = [
        "$mod,F,fullscreen"

        ### Cycle focus between windows clock and anti-clockwise ###
        "$mod,E,layoutmsg,cyclenext"
        "$mod,N,layoutmsg,cycleprev"

        ### Change active workspace ###
        "$mod,1,workspace,1"
        "$mod,2,workspace,2"
        "$mod,3,workspace,3"
        "$mod,4,workspace,4"
        "$mod,5,workspace,5"
        "$mod,6,workspace,6"
        "$mod,7,workspace,7"
        "$mod,8,workspace,8"
        "$mod,9,workspace,9"
        "$mod,0,workspace,10"

        "$mod,P,workspace,T"
        "$mod,G,workspace,S"
        "$mod,T,workspace,B"
        "$mod,M,workspace,M"

        ### Change active window ###
        # Also switch focus to the left immediately
        "$mod,right,layoutmsg,swapwithmaster master"

        # HACK: scuffed reverse swapwithmaster
        "$mod,left,layoutmsg,swapprev"
        "$mod,left,layoutmsg,focusmaster"

        "$mod,up,layoutmsg,swapnext"
        "$mod,down,layoutmsg,swapprev"

        ### Move together with the active window to another workspace ###
        "$mod CTRL,1,movetoworkspace,1"
        "$mod CTRL,2,movetoworkspace,2"
        "$mod CTRL,3,movetoworkspace,3"
        "$mod CTRL,4,movetoworkspace,4"
        "$mod CTRL,5,movetoworkspace,5"
        "$mod CTRL,6,movetoworkspace,6"
        "$mod CTRL,7,movetoworkspace,7"
        "$mod CTRL,8,movetoworkspace,8"
        "$mod CTRL,9,movetoworkspace,9"
        "$mod CTRL,0,movetoworkspace,10"

        ### Switch to a named dedicated workspace ###
        "$mod CTRL,T,movetoworkspace,B"
        "$mod CTRL,P,movetoworkspace,T"
        "$mod CTRL,G,movetoworkspace,S"
        "$mod CTRL,M,movetoworkspace,M"

        ### Move active window to another workspace without switching to it ###
        "$mod SHIFT,1,movetoworkspacesilent,1"
        "$mod SHIFT,2,movetoworkspacesilent,2"
        "$mod SHIFT,3,movetoworkspacesilent,3"
        "$mod SHIFT,4,movetoworkspacesilent,4"
        "$mod SHIFT,5,movetoworkspacesilent,5"
        "$mod SHIFT,6,movetoworkspacesilent,6"
        "$mod SHIFT,7,movetoworkspacesilent,7"
        "$mod SHIFT,8,movetoworkspacesilent,8"
        "$mod SHIFT,9,movetoworkspacesilent,9"
        "$mod SHIFT,0,movetoworkspacesilent,10"

        # Go to previous workspace
        "$mod,I,workspace,previous"

        # Go to the workspace that has risen the latest long-running job notification
        (lib.mkIf addons.to_notif.enable "$mod,O,exec,to_notif")

        ### Program launching block ###
        "$mod,Return,exec,my${mainTerminal}"
        "$mod,Q,exec,smart_kill"

        "$mod,T,exec,soft_start QtWebEngineProc qutebrowser '(B)'"
        "$mod,B,exec,qutebrowser_in_current"
        "$mod CTRL,B,exec,firefox"

        (lib.mkIf addons.swaylock.enable "$mod CTRL,X,exec,myswaylock")

        "$mod,P,exec,soft_start .telegram-deskt Telegram '(T)'"

        "$mod,G,exec,soft_start slack 'slack --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=WebRTCPipeWireCapturer %U' '(S)'"

        "$mod,M,exec,soft_start ${mainTerminalMeta.processName} '${mainTerminal} --class=${mainMusicPlayer} ${mainShell} -c ${mainMusicPlayer}' '(M)'"

        # Take screenshots
        ",F5,exec,grimblast --freeze --notify --cursor copy screen"
        "$mod,F5,exec,grimblast_save_screen"
        ",F6,exec,grimblast --freeze --notify copy area"
        "$mod,F6,exec,grimblast_save_area"

        # Video recording
        "$mod,F8,exec,wf_record_area"
        "$mod,F7,exec,wf_record_screen"

        ",F1,exec,powermenu"

        ",F4,exec,hyprpicker -a"

        # Open float to open an existing project
        "$mod,S,exec,project_search_float"
        # Open float to create a new project
        "$mod CTRL,S,exec,project_create_float"

        # Get rid of empty workspaces
        "$mod,Y,exec,hypr_organize_workspaces"

        ### Block for controlling media ###
        ",XF86AudioMute,exec,pulsemixer --toggle-mute"
        ",XF86AudioLowerVolume,exec,pulsemixer --change-volume -10"
        ",XF86AudioRaiseVolume,exec,pulsemixer_add"

        # MPRIS, can also control stuff in browser etc.
        ",XF86AudioPlay,exec,playerctl play-pause" # Toggle current song
        ",XF86AudioPrev,exec,playerctl -p ${mainMusicPlayer} previous" # Previous song
        ",XF86AudioNext,exec,playerctl -p ${mainMusicPlayer} next" # Next song
      ];
    };
  };
}
