return {
	"myypo/borrowed.nvim",
	dev = true,
	lazy = false,
	priority = 1000,

	opts = {},

	config = function()
		vim.cmd("colorscheme mayu")
	end,
}
