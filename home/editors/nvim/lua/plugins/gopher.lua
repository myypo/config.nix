return {
	"olexsmir/gopher.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	cmd = { "GoTagAdd", "GoTestAdd" },
	config = function()
		require("gopher").setup({})
	end,
}
