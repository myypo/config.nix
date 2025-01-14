return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {
		options = { "buffers" },
	},
	config = {
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				require("persistence").load()
			end,
			nested = true,
		}),
	},
}
