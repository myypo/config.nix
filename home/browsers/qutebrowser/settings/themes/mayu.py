def setup(c, samecolorrows=False):
    palette = {
        "rose": "#eba4ac",
        "love": "#eb6f92",
        "gold": "#f6c177",
        "pine": "#3e8fb0",
        "foam": "#9ccfd8",
        "text": "#e0def4",
        "subtext1": "#bac2de",
        "subtext0": "#a6adc8",
        "overlay2": "#9399b2",
        "overlay1": "#7f849c",
        "overlay0": "#6c7086",
        "surface2": "#585b70",
        "surface1": "#45475a",
        "surface0": "#313244",
        "base": "#000000",
        "mantle": "#181825",
        "crust": "#11111b",
    }

    # completion {{{
    ## Background color of the completion widget category headers.
    c.colors.completion.category.bg = palette["base"]
    ## Bottom border color of the completion widget category headers.
    c.colors.completion.category.border.bottom = palette["mantle"]
    ## Top border color of the completion widget category headers.
    c.colors.completion.category.border.top = palette["overlay2"]
    ## Foreground color of completion widget category headers.
    c.colors.completion.category.fg = palette["pine"]
    ## Background color of the completion widget for even and odd rows.
    if samecolorrows:
        c.colors.completion.even.bg = palette["mantle"]
        c.colors.completion.odd.bg = c.colors.completion.even.bg
    else:
        c.colors.completion.even.bg = palette["mantle"]
        c.colors.completion.odd.bg = palette["crust"]
    ## Text color of the completion widget.
    c.colors.completion.fg = palette["subtext0"]

    ## Background color of the selected completion item.
    c.colors.completion.item.selected.bg = palette["surface2"]
    ## Bottom border color of the selected completion item.
    c.colors.completion.item.selected.border.bottom = palette["surface2"]
    ## Top border color of the completion widget category headers.
    c.colors.completion.item.selected.border.top = palette["surface2"]
    ## Foreground color of the selected completion item.
    c.colors.completion.item.selected.fg = palette["text"]
    ## Foreground color of the selected completion item.
    c.colors.completion.item.selected.match.fg = palette["rose"]
    ## Foreground color of the matched text in the completion.
    c.colors.completion.match.fg = palette["text"]

    ## Color of the scrollbar in completion view
    c.colors.completion.scrollbar.bg = palette["crust"]
    ## Color of the scrollbar handle in completion view.
    c.colors.completion.scrollbar.fg = palette["surface2"]
    # }}}

    # downloads {{{
    c.colors.downloads.bar.bg = palette["base"]
    c.colors.downloads.error.bg = palette["base"]
    c.colors.downloads.start.bg = palette["base"]
    c.colors.downloads.stop.bg = palette["base"]

    c.colors.downloads.error.fg = palette["love"]
    c.colors.downloads.start.fg = palette["foam"]
    c.colors.downloads.stop.fg = palette["pine"]
    c.colors.downloads.system.fg = "none"
    c.colors.downloads.system.bg = "none"
    # }}}

    # hints {{{
    ## Background color for hints. Note that you can use a `rgba(...)` value
    ## for transparency.
    c.colors.hints.bg = palette["rose"]

    ## Font color for hints.
    c.colors.hints.fg = palette["mantle"]

    ## Hints
    c.hints.border = "2px solid #e0737f"

    c.colors.hints.bg = palette["rose"]
    c.colors.hints.match.fg = palette["rose"]

    # keyhints {{{
    ## Background color of the keyhint widget.
    c.colors.keyhint.bg = palette["mantle"]

    ## Text color for the keyhint widget.
    c.colors.keyhint.fg = palette["text"]

    ## Highlight color for keys to complete the current keychain.
    c.colors.keyhint.suffix.fg = palette["subtext1"]
    # }}}

    # messages {{{
    ## Background color of an error message.
    c.colors.messages.error.bg = palette["overlay0"]
    ## Background color of an info message.
    c.colors.messages.info.bg = palette["overlay0"]
    ## Background color of a warning message.
    c.colors.messages.warning.bg = palette["overlay0"]

    ## Border color of an error message.
    c.colors.messages.error.border = palette["mantle"]
    ## Border color of an info message.
    c.colors.messages.info.border = palette["mantle"]
    ## Border color of a warning message.
    c.colors.messages.warning.border = palette["mantle"]

    ## Foreground color of an error message.
    c.colors.messages.error.fg = palette["love"]
    ## Foreground color an info message.
    c.colors.messages.info.fg = palette["text"]
    ## Foreground color a warning message.
    c.colors.messages.warning.fg = palette["gold"]
    # }}}

    # prompts {{{
    ## Background color for prompts.
    c.colors.prompts.bg = palette["mantle"]

    # ## Border used around UI elements in prompts.
    c.colors.prompts.border = "1px solid " + palette["overlay0"]

    ## Foreground color for prompts.
    c.colors.prompts.fg = palette["text"]

    ## Background color for the selected item in filename prompts.
    c.colors.prompts.selected.bg = palette["surface2"]

    ## Background color for the selected item in filename prompts.
    c.colors.prompts.selected.fg = palette["rose"]
    # }}}

    # statusbar {{{
    ## Background color of the statusbar.
    c.colors.statusbar.normal.bg = palette["base"]
    ## Background color of the statusbar in insert mode.
    c.colors.statusbar.insert.bg = palette["crust"]
    ## Background color of the statusbar in command mode.
    c.colors.statusbar.command.bg = palette["base"]
    ## Background color of the statusbar in caret mode.
    c.colors.statusbar.caret.bg = palette["base"]
    ## Background color of the statusbar in caret mode with a selection.
    c.colors.statusbar.caret.selection.bg = palette["base"]

    ## Background color of the progress bar.
    c.colors.statusbar.progress.bg = palette["base"]
    ## Background color of the statusbar in passthrough mode.
    c.colors.statusbar.passthrough.bg = palette["base"]

    ## Foreground color of the statusbar.
    c.colors.statusbar.normal.fg = palette["text"]
    ## Foreground color of the statusbar in insert mode.
    c.colors.statusbar.insert.fg = palette["text"]
    ## Foreground color of the statusbar in command mode.
    c.colors.statusbar.command.fg = palette["text"]
    ## Foreground color of the statusbar in passthrough mode.
    c.colors.statusbar.passthrough.fg = palette["gold"]
    ## Foreground color of the statusbar in caret mode.
    c.colors.statusbar.caret.fg = palette["gold"]
    ## Foreground color of the statusbar in caret mode with a selection.
    c.colors.statusbar.caret.selection.fg = palette["gold"]

    ## Foreground color of the URL in the statusbar on error.
    c.colors.statusbar.url.error.fg = palette["love"]

    ## Default foreground color of the URL in the statusbar.
    c.colors.statusbar.url.fg = palette["pine"]

    ## Foreground color of the URL in the statusbar for hovered links.
    c.colors.statusbar.url.hover.fg = palette["foam"]

    ## Foreground color of the URL in the statusbar on successful load
    c.colors.statusbar.url.success.http.fg = palette["foam"]

    ## Foreground color of the URL in the statusbar on successful load
    c.colors.statusbar.url.success.https.fg = palette["pine"]

    ## Foreground color of the URL in the statusbar when there's a warning.
    c.colors.statusbar.url.warn.fg = palette["gold"]

    ## PRIVATE MODE COLORS
    ## Background color of the statusbar in private browsing mode.
    c.colors.statusbar.private.bg = palette["mantle"]
    ## Foreground color of the statusbar in private browsing mode.
    c.colors.statusbar.private.fg = palette["subtext1"]
    ## Background color of the statusbar in private browsing + command mode.
    c.colors.statusbar.command.private.bg = palette["base"]
    ## Foreground color of the statusbar in private browsing + command mode.
    c.colors.statusbar.command.private.fg = palette["subtext1"]

    # }}}

    # tabs {{{
    ## Background color of the tab bar.
    c.colors.tabs.bar.bg = palette["base"]
    ## Background color of unselected even tabs.
    c.colors.tabs.even.bg = palette["base"]
    ## Background color of unselected odd tabs.
    c.colors.tabs.odd.bg = palette["base"]

    ## Foreground color of unselected even tabs.
    # c.colors.tabs.even.fg = palette["overlay2"]
    c.colors.tabs.even.fg = palette["text"]
    ## Foreground color of unselected odd tabs.
    # c.colors.tabs.odd.fg = palette["overlay2"]
    c.colors.tabs.odd.fg = palette["text"]

    ## Color for the tab indicator on errors.
    c.colors.tabs.indicator.error = palette["love"]
    ## Color gradient interpolation system for the tab indicator.
    ## Valid values:
    ##	 - rgb: Interpolate in the RGB color system.
    ##	 - hsv: Interpolate in the HSV color system.
    ##	 - hsl: Interpolate in the HSL color system.
    ##	 - none: Don't show a gradient.
    c.colors.tabs.indicator.system = "none"
    c.colors.tabs.indicator.start = palette["base"]
    c.colors.tabs.indicator.stop = palette["pine"]

    # ## Background color of selected even tabs.
    c.colors.tabs.selected.even.bg = palette["gold"]
    # ## Background color of selected odd tabs.
    c.colors.tabs.selected.odd.bg = palette["gold"]

    # ## Foreground color of selected even tabs.
    c.colors.tabs.selected.even.fg = palette["base"]
    # ## Foreground color of selected odd tabs.
    c.colors.tabs.selected.odd.fg = palette["base"]
    # }}}

    # context menus {{{
    c.colors.contextmenu.menu.bg = palette["base"]
    c.colors.contextmenu.menu.fg = palette["text"]

    c.colors.contextmenu.disabled.bg = palette["mantle"]
    c.colors.contextmenu.disabled.fg = palette["overlay0"]

    c.colors.contextmenu.selected.bg = palette["overlay0"]
    c.colors.contextmenu.selected.fg = palette["rose"]
    # }}}

    # background color for webpages {{{
    c.colors.webpage.bg = palette["base"]
    # }}}
