return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({
			enable_check_bracket_line = true,
			disable_in_macro = false,
			check_ts = true,
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			fast_wrap = {
				map = "<C-s>",
				-- Colemak-DH optimization
				keys = "arstgmneiowfpluyxcdh,.qbj'zvk/",
			},
		})

		local cmp_na = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		-- To autoinsert () on choosing function/method
		cmp.event:on(
			"confirm_done",
			cmp_na.on_confirm_done({
				filetypes = {
					roc = false,
					lean = false,
					nix = false,
				},
			})
		)

		local na = require("nvim-autopairs")
		na.get_rule("'")[1].not_filetypes = { "rescript" }
	end,
}
