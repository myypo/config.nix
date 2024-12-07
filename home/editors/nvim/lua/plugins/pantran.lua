return {
	"potamides/pantran.nvim",
	keys = {
		{ "<Leader>t", '"Ty<Cmd>Pantran<CR>"Tp', mode = "v" },
	},
	config = function()
		require("pantran").setup({
			default_engine = "google",
			default_source = "auto",
			default_target = "en",
		})
		require("pantran").motion_translate()
	end,
}
