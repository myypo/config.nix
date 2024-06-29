set -l pink_plain eba4ac
set -l pink (set_color $pink_plain)
set -l red (set_color eb6f92)
set -l breeze_plain 9ccfd8
set -l breeze (set_color $breeze_plain)
set -l yellow (set_color f6c177)
set -l green (set_color 3e8fb0)

set -g hydro_symbol_reg_prompt "🎀"
set -g hydro_symbol_nix_prompt "❄️"

set -g hydro_symbol_git_dirty "$yellow󰫢 "
set -g hydro_symbol_git_ahead "$green↑"
set -g hydro_symbol_git_behind "$red↓"
set -g hydro_symbol_git_pre "$yellow"git":("
set -g hydro_symbol_git_post "$yellow)"
set -g hydro_git_branch_color $red

set -g hydro_fetch true

set -g hydro_color_reg_pwd $pink_plain
set -g hydro_color_nix_pwd $breeze_plain
set -g fish_prompt_pwd_dir_length 1

set -g hydro_multiline true
