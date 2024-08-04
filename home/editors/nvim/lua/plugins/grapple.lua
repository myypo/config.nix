return {
	"cbochs/grapple.nvim",
	keys = {
		{ "<leader>f", "<Cmd>Grapple open_tags<CR>" },

		{ "<C-S-n>", "<Cmd>Grapple tag key=n name=n<CR>" },
		{ "<C-S-e>", "<Cmd>Grapple tag key=e name=e<CR>" },
		{ "<C-S-h>", "<Cmd>Grapple tag key=h name=h<CR>" },
		{ "<C-S-,>", "<Cmd>Grapple tag key=, name=,<CR>" },

		{ "<C-n>", "<Cmd>Grapple select name=n<CR>" },
		{ "<C-e>", "<Cmd>Grapple select name=e<CR>" },
		{ "<C-h>", "<Cmd>Grapple select name=h<CR>" },
		{ "<C-,>", "<Cmd>Grapple select name=,<CR>" },
	},
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("grapple").setup({
			win_opts = {
				border = "rounded",
			},
		})
	end,
}
