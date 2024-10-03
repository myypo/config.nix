return {
	"glepnir/lspsaga.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	keys = { { "R", "<Cmd>Lspsaga hover_doc<CR>" } },

	config = function()
		require("lspsaga").setup({
			lightbulb = {
				enable = false,
			},
			beacon = {
				enable = false,
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
