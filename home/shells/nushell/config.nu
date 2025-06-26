def fetch [url] {
    let prot_url = match ($url =~ '^localhost:\d+') {
        true  => $"http://($url)"
        false => $"https://($url)"
    }
    http get --headers [Accept application/json] $prot_url
}

let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}

let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        nu => $fish_completer
        git => $fish_completer
        asdf => $fish_completer
        _ => $carapace_completer
    } | do $in $spans
}

let auto_pair_keybinds = [
  {
    name: "paren"
    left: "("
    right: ")"
  }
  {
    name: "curly_bracket"
    left: "{"
    right: "}"
  }
  {
    name: "bracket"
    left: "["
    right: "]"
  }
  {
    name: "quote"
    left: '"'
    right: '"'
  }
  {
    name: "single_quote"
    left: "'"
    right: "'"
  }
]

let main_keybinds = [
    {
      name: run_dir_fzf
      modifier: control
      keycode: char_d
      mode: [emacs, vi_normal, vi_insert]
      event: {
        send: executehostcommand,
        cmd: "commandline edit --insert (fd . -td | fzf)"
      }
    }
    {
      name: run_file_fzf
      modifier: control
      keycode: char_f
      mode: [emacs, vi_normal, vi_insert]
      event: {
        send: executehostcommand,
        cmd: "commandline edit --insert (fd . -tf | fzf)"
      }
    }
    {
        name: run_zoxide
        modifier: control
        keycode: char_s
        mode: [emacs, vi_normal, vi_insert]
        event: {
        send: executehostcommand
        cmd: zi
        }
    }
    {
        name: run_command
        modifier: none
        keycode: enter
        mode: emacs
        event: { send: submit }
    }
    {
        name: insert_newline
        modifier: shift
        keycode: enter
        mode: [emacs, vi_insert]
        event: [
            { edit: insertnewline }
            { edit: insertchar value: "|" }
            { edit: insertchar value: " " }
        ]
    }
    {
        name: completion_menu
        modifier: control
        keycode: char_t
        mode: [emacs vi_normal vi_insert]
        event: {
            until: [
                { send: menu name: completion_menu }
            ]
        }
    }
    {
        name: complete
        modifier: none
        keycode: tab
        mode: [emacs vi_normal vi_insert]
        event: {
            until: [
                { send: historyhintcomplete }
            ]
        }
    }
    {
        name: fuzzy_history
        modifier: control
        keycode: char_r
        mode: [emacs, vi_normal, vi_insert]
        event: {
          send: executehostcommand
          cmd: "commandline edit -r (history | each { |it| $it.command } | uniq | reverse | str join (char -i 0) | | fzf --read0 --layout=reverse --height=40% -q (commandline) | decode utf-8 | str trim)"
        }
    }
    {
        name: run_last_command
        modifier: control
        keycode: char_l
        mode: [emacs, vi_normal, vi_insert]
        event: {
          send: executehostcommand
          cmd: "nu -c (history | where command !~ 'history' | last | get command | str trim)"
        }
    }
    {
        name: open_command_editor
        modifier: control
        keycode: char_e
        mode: [emacs, vi_normal, vi_insert]
        event: { send: openeditor }
    }
    {
        name: paste_system
        modifier: control
        keycode: char_v
        mode: [emacs, vi_normal, vi_insert]
        event: { edit: pastesystem }
    }
]

let keybindings = $main_keybinds ++ (
    $auto_pair_keybinds | each {|k| {
        name: $"autopair_($k.name)"
        modifier: none
        keycode: $"char_($k.left)"
        mode: [emacs, vi_normal, vi_insert]
        event: [
            { edit: InsertChar value: $k.left }
            { edit: InsertChar value: $k.right },
            { edit: MoveLeft }
        ]
  }}
)

$env.config = {
    show_banner: false
    buffer_editor: vim
    use_kitty_protocol: true 
    edit_mode: emacs
    shell_integration: {
        osc2: true
        osc7: true
        osc8: true
        osc9_9: false
        osc133: true
        osc633: true
        reset_application_mode: true
    }

    ls: {
        use_ls_colors: false
    }
    table: {
        mode: rounded
        index_mode: auto 
    }
    rm: {
        always_trash: true
    }
    cursor_shape: {
        vi_insert: line 
        vi_normal: block
    }

    completions: {
        external: {
            enable: true
            completer: $external_completer
        }
        use_ls_colors: false
    }
    
    keybindings: $keybindings
}
