return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons", "myypo/borrowed.nvim" },
	config = function()
		require("lualine.themes.borrowed").setup()
	end,
}
