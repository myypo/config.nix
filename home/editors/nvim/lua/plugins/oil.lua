return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "m", "<Cmd>Oil<CR>", desc = "Oil" },
	},
	config = function()
		require("oil").setup({
			keymaps = {
				["m"] = "actions.close",
				["="] = "actions.parent",
				[";"] = "actions.refresh",
				["<C-w>"] = "actions.select_vsplit",
				["~"] = false,
				["-"] = false,
				["_"] = false,
				["`"] = false,
				["<C-h>"] = false,
				["<C-s>"] = false,
				["<C-t>"] = false,
			},
			view_options = {
				is_always_hidden = function(name, _)
					if name == "node_modules" or name == "vendor" then
						return true
					end
					return false
				end,
			},
		})
	end,
}
