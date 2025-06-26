return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local np = require("nvim-autopairs")

		np.setup({
			enable_check_bracket_line = true,
			disable_in_macro = false,
			check_ts = true,
			ts_config = {
				lua = { "string" }, -- Don't add pairs in lua string treesitter nodes
				javascript = { "template_string" }, -- Don't add pairs in javascript template_string
				rust = {},
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			fast_wrap = {
				map = "<C-s>",
				-- Colemak-DH optimization
				keys = 'arstgmneiowfpluyxcdh,.qbj"zvk/',
				before_key = "n",
				after_key = "e",
			},
		})

		local Rule = require("nvim-autopairs.rule")
		local conds = require("nvim-autopairs.conds")

		np.add_rules({
			Rule("<", ">"):with_pair(conds.before_regex("%a+")):with_move(function(opts)
				return opts.char == ">"
			end),
			Rule("*", "*", { "markdown" }):with_pair(conds.not_before_regex("\n")),
			Rule("_", "_", { "markdown" }):with_pair(conds.before_regex("%s")),
		})

		local na = require("nvim-autopairs")
		na.get_rule("'")[1].not_filetypes = { "rust" }
	end,
}
