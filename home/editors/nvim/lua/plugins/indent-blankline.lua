return {
	"lukas-reineke/indent-blankline.nvim",
	event = "VeryLazy",
	config = function()
		require("ibl").setup({
			scope = {
				enabled = false,
			},
		})
	end,
}
