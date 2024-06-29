function t
    set -l path $HOME/code
    set -l selected_dir (
      find $path/* -maxdepth 2 -mindepth 2 -type d |
        sed "s~$path/~~" |
        fzf | 
        sed "s~^~$path/~"
    )

    if test -n "$selected_dir"
        set -l kitty_pid
        for file in (find /tmp/kitty-*)
            set kitty_pid (kitten @ --to unix:"$file" ls | jq -r '.[0].tabs | first(select(.[].windows[].cwd == "'$selected_dir'")) | first(.[].windows[0].pid)')
            if test -n "$kitty_pid"
                break
            end
        end
        if test -n "$kitty_pid"
            set -l hypr_pid (ps -o ppid= -p "$kitty_pid" | awk '{print $1}')
            hyprctl dispatch focuswindow pid:"$hypr_pid" >/dev/null 2>&1
            return
        end

        cd $selected_dir
        set -gx PROJ_PATH (pwd)

        v
    end
end
