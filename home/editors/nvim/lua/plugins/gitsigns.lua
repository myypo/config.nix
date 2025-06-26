return {
	"lewis6991/gitsigns.nvim",
	event = "BufRead",
	config = function()
		local gitsigns = require("gitsigns")

		Keymap("n", "<C-Down>", function()
			local old = vim.o.lazyredraw
			vim.o.lazyredraw = true
			gitsigns.nav_hunk("next", { target = "all" })
			vim.api.nvim_command("normal! zz")
			vim.o.lazyredraw = old
		end)
		Keymap("n", "<C-Up>", function()
			local old = vim.o.lazyredraw
			vim.o.lazyredraw = true
			gitsigns.nav_hunk("prev", { target = "all" })
			vim.api.nvim_command("normal! zz")
			vim.o.lazyredraw = old
		end)
		Keymap("n", "<Leader>h", function()
			gitsigns.preview_hunk_inline()
		end)

		gitsigns.setup({
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			signcolumn = true,
			attach_to_untracked = true,
		})
	end,
}
