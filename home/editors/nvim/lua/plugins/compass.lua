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
		-- marks = {
		-- 	signs = {
		-- 		past = "",
		-- 		close_past = "",
		-- 		future = "",
		-- 		close_future = "",
		-- 	},
		-- },
		-- persistence = {
		-- 	interval_milliseconds = "",
		-- },
	},

	-- event = "BufReadPost",
	keys = {
		{ "<C-f>", "<Cmd>Compass open<CR>" },
		{
			"<C-t>",
			"<Cmd>Compass goto relative direction=back<CR>",
		},
		-- {
		-- 	"<C-t>",
		-- 	"<Cmd>Compass pop relative direction=back<CR>",
		-- },
		{
			"<C-S-t>",
			"<Cmd>Compass goto relative direction=forward<CR>",
		},
		-- {
		-- 	"<C-S-t>",
		-- 	"<Cmd>Compass pop relative direction=forward<CR>",
		-- },
	},
}
