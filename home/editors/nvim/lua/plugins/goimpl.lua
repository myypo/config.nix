return {
	"edolphin-ydf/goimpl.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-lua/popup.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{
			"<Leader>j",
			"<Cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>",
			desc = "Telescope impl go interface",
		},
	},
	config = function()
		require("telescope").load_extension("goimpl")
	end,
}
