function __postexec_notify_on_long_running_commands --on-event fish_postexec
    set -l __last_command_exit_status $status

    if test $CMD_DURATION -lt 5000
        return
    end

    # Do not call a notification for the following commands taking over specified time
    set --function interactive_commands v vim mpv mpd zathura man less rgr wine fzf f nemo t tinit
    set --function command (string split ' ' $argv[1])
    if contains $command $interactive_commands
        return
    end

    set -l kitty_win_meta (kitty @ ls | jq -e ".[].tabs.[] | select(any(.windows.[]; .is_self))" 2>/dev/null)
    set -l is_current (echo $kitty_win_meta | jq -r .is_focused)
    if test $is_current = true
        return
    end

    set -l kitty_pid (echo $kitty_win_meta | jq -r .windows.[0].pid)
    set -l hypr_win_pid (ps -o ppid= -p $kitty_pid | awk '{print $1}')
    set -l hypr_ws_name (hyprctl clients -j | jq -r '.[] | select(.pid == '$hypr_win_pid').workspace.name')

    if test $__last_command_exit_status != 0
        notify-send -u critical "💢 $hypr_ws_name 💢" "$(echo -e "$argv\n$PWD")" --hint=string:desktop-entry:$hypr_win_pid
    else
        notify-send "✨ $hypr_ws_name ✨" "$(echo -e "$argv\n$PWD")" --hint=string:desktop-entry:$hypr_win_pid
    end
end
