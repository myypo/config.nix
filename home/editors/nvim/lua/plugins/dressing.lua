return {
	"stevearc/dressing.nvim",
	opts = {
		input = {
			mappings = {
				n = {
					["<C-a>"] = "Close",
					["<CR>"] = "Confirm",
				},
				i = {
					["<C-a>"] = "Close",
					["<CR>"] = "Confirm",
					["<Up>"] = "HistoryPrev",
					["<Down>"] = "HistoryNext",
				},
			},
		},
		select = {
			telescope = require("telescope.themes").get_cursor({}),
		},
	},
}
