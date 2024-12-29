# pyright: reportUndefinedVariable=false

# pyright: reportMissingImports=false

# the theme module is dynamically put on home-manager build
import theme

config.load_autoconfig(False)
theme.setup(c, True)

c.completion.height = "20%"
c.auto_save.session = True

c.tabs.position = "left"
# Use relative numbers for tabs
c.tabs.title.format = "{relative_index}: {current_title}"

c.statusbar.position = "top"
c.fonts.tabs.selected = "13pt default_family"
c.fonts.tabs.unselected = "13pt default_family"

c.fonts.hints = "bold 14pt default_family"
c.fonts.statusbar = "bold 15pt default_family"
c.fonts.prompts = "15pt sans-serif"
c.fonts.completion.category = "bold 15pt default_family"
c.fonts.completion.entry = "15pt default_family"
c.fonts.messages.error = "15pt default_family"

c.completion.shrink = True
c.zoom.default = "160%"

c.hints.uppercase = True

c.content.javascript.clipboard = "access-paste"
c.content.autoplay = False

# Colemak-DH optimized hints
c.hints.chars = 'arstgmneiowfpluyxcdh,.qbj"zvk/'

c.colors.webpage.darkmode.enabled = True

c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.threshold.foreground = 150
c.colors.webpage.darkmode.threshold.background = 100
c.colors.webpage.darkmode.policy.images = "never"
c.colors.webpage.bg = "black"

config.bind("m", "config-cycle tabs.show always never")

config.bind("i", "hint inputs --first")
config.bind("t", "hint")
config.bind("T", "hint all tab-bg")
config.bind("h", "hint all hover")

# Detach and go with the tab to the previous workspace
# useful for bringing docs to the relevant terminal
config.bind("gd", "tab-give ;; spawn --detach to_prev_workspace 1")

config.bind("<down>", "scroll-page 0 0.20", mode="normal")
config.bind("<up>", "scroll-page 0 -0.20", mode="normal")

config.bind("<Ctrl-n>", "tab-next", mode="normal")
config.bind("<Ctrl-e>", "tab-prev", mode="normal")

config.bind("<Ctrl-Shift-n>", "tab-move +", mode="normal")
config.bind("<Ctrl-Shift-e>", "tab-move -", mode="normal")

config.bind("m", "move-to-prev-char", mode="caret")
config.bind("n", "move-to-next-line", mode="caret")
config.bind("e", "move-to-prev-line", mode="caret")
config.bind("i", "move-to-next-char", mode="caret")

config.bind("M", "scroll left", mode="caret")
config.bind("N", "scroll down", mode="caret")
config.bind("E", "scroll up", mode="caret")
config.bind("I", "scroll right", mode="caret")

c.url.default_page = "https://www.google.com"
c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
    "np": "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}",
    "no": "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}",
    "r": "https://www.reddit.com/r/{}",
    "gr": "https://github.com/search?q={}&type=repositories",
    "gc": "https://github.com/search?q={}&type=code",
    "w": "https://en.wikipedia.org/wiki/{}",
    "y": "https://www.youtube.com/results?search_query={}",
    "toho": "https://en.touhouwiki.net/index.php?search={}&title=Special%3ASearch&go=Go",
}
