function t-new-term
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
        clear
        if test -n "$kitty_pid"
            set -l hypr_pid (ps -o ppid= -p "$kitty_pid" | awk '{print $1}')
            hyprctl dispatch focuswindow pid:"$hypr_pid" >/dev/null 2>&1
            return
        end

        set -l empty_ws (hyprctl workspaces -j | jq -r '[.[] | select(.id > 0 and (.lastwindowtitle != "project_search_float" or .windows > 1))] | (map(.id) | sort | reduce .[] as $id (1; if . >= $id then . + 1 else . end))')
        if [ "$empty_ws" != (hyprctl activeworkspace -j | jq -r .id) ]
            hyprctl dispatch workspace $empty_ws >/dev/null 2>&1
        end

        set -x PROJ_PATH $selected_dir
        # HACK: Have to defer a window resize function because hyprland might scuff window sizes, when there were at least two windows saved with persistence.nvim
        setsid kitty -d $selected_dir --hold --listen-on unix:/tmp/kitty-(random) fish -c "kitty @ launch --copy-env --spacing padding=0 --cwd=current --type=tab nvim -c 'lua vim.defer_fn(function() vim.cmd(\"windo resize 100 | vertical resize 100\") end, 200)' >/dev/null 2>&1" &
        for cho_flo_pid in (hyprctl clients -j | jq -r '.[] | select(.class == "project_management_float") | .pid')
            kill $cho_flo_pid >/dev/null 2>&1
        end
    end
end
