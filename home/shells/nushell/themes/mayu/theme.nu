let rose = "#eba4ac" 
let gold = "#f6c177"
let pine = "#3e8fb0"
let love = "#eb6f92"
let blanket = "#26233a"
let plain = "#e0def4"
let muted = "#6e6a86"
let subtle = "#908caa"
let sheet = "#121212"
let mattress = "#000000"

let mayu_theme = {
    separator: $subtle
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: $rose attr: "b" }
    empty: $blanket
    bool: $love
    int: $love
    duration: $gold
    filesize: $gold
    date: $gold
    range: $love
    float: $love
    string: $pine
    nothing: $love
    binary: $subtle
    cell-path: $plain
    row_index: $plain
    record: $plain
    list: $plain
    block: $plain
    hints: $muted
    search_result: $subtle

    shape_and: $subtle
    shape_binary: $subtle
    shape_block: $subtle
    shape_bool: $love
    shape_closure: $subtle
    shape_custom: $gold
    shape_datetime: $gold
    shape_directory: { fg: $gold attr: "u" }
    shape_external: $plain
    shape_externalarg: $gold
    shape_external_resolved: $gold
    shape_filepath: { fg: $gold attr: "u" }
    shape_flag: $gold
    shape_float: $love
    shape_garbage: { fg: $mattress bg: $love }
    shape_globpattern: $gold
    shape_int: { fg: $love attr: "b" }
    shape_internalcall: $plain
    shape_list: $plain
    shape_literal: $gold
    shape_match_pattern: $gold
    shape_nothing: $love
    shape_operator: $subtle
    shape_or: $subtle
    shape_pipe: $subtle
    shape_range: $love
    shape_record: $subtle
    shape_redirection: $subtle
    shape_signature: $subtle
    shape_string: $pine
    shape_string_interpolation: $pine
    shape_table: $subtle
    shape_variable: $rose
    shape_vardecl: $rose
    shape_raw_string: $pine
}


$env.config.color_config = $mayu_theme

$env.config.explore = {
    status_bar_background: { fg: $rose, bg: $sheet attr: "b" },
    command_bar_text: { fg: $plain },
    highlight: { fg: $mattress, bg: $gold attr: "b" },
    status: {
        error: { fg: $mattress, bg: $love },
        warn: {}
        info: {}
    },
    selected_cell: { fg: $mattress bg: $gold attr: "b" },
}

$env.config.menus = [
    {
        name: completion_menu
        only_buffer_difference: false
        marker: ""
        type: {
            layout: columnar
            columns: 6
            col_width: 20
            col_padding: 2
        }
        style: {
            text: $subtle
            selected_text: { fg: $rose attr: u }
            description_text: $subtle
            match_text: $plain
            selected_match_text: { fg: $rose attr: u }
        }
    }
    {
        name: history_menu
        only_buffer_difference: true
        marker: ""
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: $subtle
            selected_text: { fg: $rose attr: u }
            description_text: $subtle
        }
    }
]

