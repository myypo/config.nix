return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufRead",

	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			sync_install = false,
			auto_install = false,

			indent = { enable = false },

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
