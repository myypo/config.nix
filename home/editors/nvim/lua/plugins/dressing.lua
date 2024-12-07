return {
	"stevearc/dressing.nvim",
	opts = {
		input = {
			mappings = {
				n = {
					["<C-t>"] = "Close",
					["<CR>"] = "Confirm",
				},
				i = {
					["<C-t>"] = "Close",
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
