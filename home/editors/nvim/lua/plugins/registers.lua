return {
	"tversteeg/registers.nvim",
	keys = {
		{ '"', mode = { "n", "v" } },
		{
			"<C-r>",
			mode = "i",
		},
	},
	opts = { show = "0123456789", show_empty = false, show_register_types = false },
}
