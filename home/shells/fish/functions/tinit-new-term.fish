function tinit-new-term
    set -l path $HOME/code
    set -l selected_dir (
      find $path/* -maxdepth 1 -mindepth 1 -type d |
        sed "s~$path/~~" |
        fzf | 
        sed "s~^~$path/~"
    )

    if test -n "$selected_dir"
        while true
            echo "Enter new project name or git repo url:"

            read proj_str
            if test -z $proj_str
                return
            end

            cd $selected_dir

            if string match -q "https://*" $proj_str || string match -q "git@*" $proj_str
                git clone $(string lower $proj_str)
                or echo "Failed to clone, please, check the provided remote repo url" && continue

                set -l repo_name (basename -s .git "$proj_str")
                cd $repo_name
                break
            else
                mkdir $proj_str
                cd $proj_str
                git init
                break
            end
        end

        set -l empty_ws (hyprctl workspaces -j | jq -r '[.[] | select(.id > 0 and (.lastwindowtitle != "project_create_float" or .windows > 1))] | (map(.id) | sort | reduce .[] as $id (1; if . >= $id then . + 1 else . end))')

        if [ "$empty_ws" != (hyprctl activeworkspace -j | jq -r .id) ]
            hyprctl dispatch workspace $empty_ws >/dev/null 2>&1
        end

        set -x PROJ_PATH (pwd)
        setsid kitty --hold --listen-on unix:/tmp/kitty-(random) fish -c "kitty @ launch --copy-env --spacing padding=0 --cwd=current --type=tab nvim >/dev/null 2>&1" &
        for cho_flo_pid in (hyprctl clients -j | jq -r '.[] | select(.class == "project_management_float") | .pid')
            kill $cho_flo_pid >/dev/null 2>&1
        end
    end
end
