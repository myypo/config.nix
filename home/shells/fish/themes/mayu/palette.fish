# --> palette
set -l white e0def4
set -l pink eba4ac
set -l red eb6f92
set -l breeze 9ccfd8
set -l yellow f6c177
set -l green 3e8fb0
set -l gray 6e6a86

# Syntax Highlighting
set -g fish_color_normal $gray
set -g fish_color_command $white
set -g fish_color_param $yellow
set -g fish_color_keyword $green
set -g fish_color_quote $green
set -g fish_color_redirection $green
set -g fish_color_end $red
set -g fish_color_error $red
set -g fish_color_gray $gray
set -g fish_color_selection --background=$gray
set -g fish_color_search_match --background=$gray
set -g fish_color_operator $yellow
set -g fish_color_escape $yellow
set -g fish_color_autosuggestion $gray
set -g fish_color_cancel $red

# Prompt
set -g fish_color_cwd $pink
set -g fish_color_user $breeze
set -g fish_color_host $yellow

# Completion Pager
set -g fish_pager_color_progress $gray
set -g fish_pager_color_prefix $white
set -g fish_pager_color_completion $gray
set -g fish_pager_color_description $gray
set -g fish_pager_color_selected_completion $gray
set -g fish_pager_color_selected_description $gray
set -g fish_pager_color_selected_background --background=$gray
