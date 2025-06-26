return {
	"folke/snacks.nvim",
	opts = {
		gitbrowse = { enable = true },
	},
	keys = {
		{
			"<Leader>b",
			function()
				require("snacks").gitbrowse()
			end,
		},
	},
}
