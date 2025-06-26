return {
	"toppair/peek.nvim",
	build = "deno task --quiet build:fast",
	keys = {
		{
			"<Leader>m",
			function()
				require("peek").open()
			end,
		},
	},
	config = function()
		require("peek").setup({
			auto_load = true,

			close_on_bdelete = true,

			syntax = true,

			theme = "dark",

			update_on_change = true,

			app = "browser",

			filetype = { "markdown" },

			throttle_at = 200000,
			throttle_time = "auto",
		})
	end,
}
