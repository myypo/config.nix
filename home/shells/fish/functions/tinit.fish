function tinit
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

        set -gx PROJ_PATH (pwd)
        v
    end
end
