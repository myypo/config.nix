return {
	"myypo/borrowed.nvim",
	dev = true,
	lazy = false,
	priority = 1000,

	config = function()
		require("borrowed").setup({
			overrides = {
				groups = {
					all = {
						LspReferenceText = {},
						LspReferenceRead = {},
						LspReferenceWrite = {},
					},
				},
			},
		})

		vim.cmd("colorscheme mayu")
	end,
}
