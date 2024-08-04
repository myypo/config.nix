return {
	"windwp/nvim-autopairs",
	dependencies = { "hrsh7th/nvim-cmp" },
	event = "InsertEnter",
	config = function()
		local status_ok, npairs = pcall(require, "nvim-autopairs")
		if not status_ok then
			return
		end

		npairs.setup({
			check_ts = true,
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
				java = false,
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			fast_wrap = {
				map = "<C-s>",
			},
		})
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp_status_ok, cmp = pcall(require, "cmp")
		if not cmp_status_ok then
			return
		end
		-- To autoinsert () on choosing function/method
		cmp.event:on(
			"confirm_done",
			cmp_autopairs.on_confirm_done({
				filetypes = {
					roc = false,
					lean = false,
					nix = false,
				},
			})
		)

		require("nvim-autopairs").get_rules("(")[1].not_filetypes = { "roc", "nix", "lean" }
	end,
}
