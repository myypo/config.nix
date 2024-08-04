return {
	"lewis6991/gitsigns.nvim",
	event = "BufRead",
	config = function()
		local keymap = vim.keymap.set
		keymap("n", "<C-Down>", "<Cmd>Gitsigns next_hunk<CR>zz")
		keymap("n", "<C-Up>", "<Cmd>Gitsigns prev_hunk<CR>zz")
		keymap("n", "<Leader>h", "<Cmd>Gitsigns preview_hunk_inline<CR>")

		require("gitsigns").setup({

			signs = {
				add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
				change = {
					hl = "GitSignsChange",
					text = "│",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
				topdelete = {
					hl = "GitSignsDelete",
					text = "‾",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = "~",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
			},
			signcolumn = true,
			attach_to_untracked = true,
		})
	end,
}
