return {
	"tversteeg/registers.nvim",
	keys = {
		{ '"', mode = { "n" } },
		{
			"<C-r>",
			mode = "i",
		},
	},
	config = function()
		local registers = require("registers")
		---@diagnostic disable-next-line: missing-fields
		registers.setup({
			show = "0123456789",
			show_empty = false,
			show_register_types = false,

			---@diagnostic disable-next-line: missing-fields
			bind_keys = {
				normal = registers.show_window({ mode = "paste", delay = 0 }),
				visual = registers.show_window({ mode = "paste", delay = 0 }),
				insert = registers.show_window({ mode = "insert", delay = 0 }),
				registers = registers.apply_register({ delay = 0.1 }),
				["<CR>"] = registers.apply_register(),
				["<Esc>"] = registers.close_window(),
				["<Del>"] = registers.clear_highlighted_register(),
				["<BS>"] = registers.clear_highlighted_register(),
			},
		})
	end,
}
