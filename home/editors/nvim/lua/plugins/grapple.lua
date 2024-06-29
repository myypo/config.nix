return {
	"cbochs/grapple.nvim",
	keys = {
		{ "<leader>f", "<Cmd>Grapple open_tags<CR>", desc = "" },

		{ "<C-S-n>", "<Cmd>Grapple tag key=n name=n<CR>", desc = "" },
		{ "<C-S-e>", "<Cmd>Grapple tag key=e name=e<CR>", desc = "" },
		{ "<C-S-h>", "<Cmd>Grapple tag key=h name=h<CR>", desc = "" },
		{ "<C-S-,>", "<Cmd>Grapple tag key=, name=,<CR>", desc = "" },

		{ "<C-n>", "<Cmd>Grapple select name=n<CR>", desc = "" },
		{ "<C-e>", "<Cmd>Grapple select name=e<CR>", desc = "" },
		{ "<C-h>", "<Cmd>Grapple select name=h<CR>", desc = "" },
		{ "<C-,>", "<Cmd>Grapple select name=,<CR>", desc = "" },
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
