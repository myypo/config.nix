return {
	"myypo/borrowed.nvim",
	dev = true,
	lazy = false,
	priority = 1000,

	config = function()
		require("borrowed").setup({
			modules = {
				compass = { enable = true },
			},
		})

		vim.cmd("colorscheme mayu")
	end,
}
