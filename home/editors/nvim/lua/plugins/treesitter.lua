return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufRead",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	config = function()
		local configs = require("nvim-treesitter.configs")

		---@diagnostic disable-next-line: missing-fields
		configs.setup({
			sync_install = false,
			auto_install = false,

			indent = { enable = false },

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					include_surrounding_whitespace = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["as"] = "@class.outer",
						["is"] = "@class.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["<C-S-d>"] = "@function.outer",
					},
					goto_previous_start = {
						["<C-S-u>"] = "@function.outer",
					},
				},
			},
		})
	end,
}
