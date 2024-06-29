return {
	"glepnir/lspsaga.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	keys = { { "R", "<Cmd>Lspsaga hover_doc<CR>", desc = "LspSaga hover" } },

	config = function()
		require("lspsaga").setup({
			lightbulb = {
				enable = false,
			},
			outline = {
				win_width = 25,
			},
			symbol_in_winbar = {
				enable = false,
			},
			hover = {
				open_cmd = "!qutebrowser",
			},
		})
	end,
}
