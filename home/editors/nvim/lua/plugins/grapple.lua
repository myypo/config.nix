return {
	"cbochs/grapple.nvim",
	keys = {
		{ "<C-S-t>", "<Cmd>Grapple tag key=t name=t<CR>" },
		{ "<C-S-s>", "<Cmd>Grapple tag key=s name=s<CR>" },
		{ "<C-S-c>", "<Cmd>Grapple tag key=c name=c<CR>" },
		{ "<C-S-d>", "<Cmd>Grapple tag key=d name=d<CR>" },

		{ "<C-t>", "<Cmd>Grapple select name=t<CR>" },
		{ "<C-s>", "<Cmd>Grapple select name=s<CR>" },
		{ "<C-c>", "<Cmd>Grapple select name=c<CR>" },
		{ "<C-d>", "<Cmd>Grapple select name=d<CR>" },
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
