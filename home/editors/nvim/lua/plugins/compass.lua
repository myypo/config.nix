return {
	dir = "~/code/my/projects/compass.nvim",

	opts = {
		picker = {
			jump_keys = {
				{ "n", "N" },
				{ "t", "T" },
				{ "e", "E" },
				{ "s", "S" },
				{ "i", "I" },
				{ "r", "R" },
				{ "o", "O" },
				{ "a", "A" },
				{ "m", "M" },
				{ "g", "G" },
			},
		},
		tracker = {
			signs = {
				past = "",
				close_past = "",
				future = "",
				close_future = "",
			},
		},
	},

	-- event = "BufReadPost",
	keys = {
		{ "<C-f>", "<Cmd>Compass open<CR>" },
		{
			"<C-t>",
			"<Cmd>Compass goto relative direction=back<CR>",
		},
		{
			"<C-S-t>",
			"<Cmd>Compass goto relative direction=forward<CR>",
		},
	},
}
