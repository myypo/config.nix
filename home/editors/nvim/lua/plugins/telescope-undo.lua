return {
	"debugloop/telescope-undo.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
	},

	keys = {
		{
			"<leader>u",
			"<Cmd>Telescope undo<CR>",
			desc = "Telescope undo history",
		},
	},

	config = function()
		require("telescope").setup({
			extensions = {
				undo = {
					mappings = {
						i = {
							["<CR>"] = require("telescope-undo.actions").restore,
						},
						n = {
							["<CR>"] = require("telescope-undo.actions").restore,
						},
					},
				},
			},
		})
	end,
}
