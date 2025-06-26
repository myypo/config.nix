return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },

	config = function()
		local actions = require("diffview.config").actions

		require("diffview").setup({

			enhanced_diff_hl = true,

			keymaps = {
				disable_defaults = true,

				view = {
					{ "n", "<C-n>", actions.select_next_entry },
					{ "n", "<C-e>", actions.select_prev_entry },
					{ "n", "gf", actions.goto_file_edit },

					{ "n", "<Leader>n", actions.conflict_choose("ours") },
					{ "n", "<Leader>e", actions.conflict_choose("theirs") },
					{ "n", "<Leader>i", actions.conflict_choose("all") },
					{ "n", "<Leader>o", actions.conflict_choose("base") },
					{ "n", "<Leader>N", actions.conflict_choose_all("ours") },
					{ "n", "<Leader>E", actions.conflict_choose_all("theirs") },
					{ "n", "<Leader>I", actions.conflict_choose_all("all") },
					{ "n", "<Leader>O", actions.conflict_choose_all("base") },
				},

				file_panel = {
					{ "n", "<CR>", actions.select_entry },
				},

				file_history_panel = {
					{ "n", "<CR>", actions.select_entry },
				},
			},
		})
	end,
}
