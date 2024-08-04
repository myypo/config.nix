return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },

	config = function()
		local actions = require("diffview.config").actions

		require("diffview").setup({

			enhanced_diff_hl = true,

            -- stylua: ignore
			keymaps = {
				disable_defaults = true,

                view = {
                    { "n", "<C-n>",       actions.select_next_entry,   { desc = "Open the diff for the next file" } },
                    { "n", "<C-S-n>",     actions.select_prev_entry,   { desc = "Open the diff for the previous file" } },
                    { "n", "gf",          actions.goto_file_edit,      { desc = "Open the file in the previous tabpage" } },
                },

                file_panel = {
                    { "n", "<CR>",        actions.select_entry,        { desc = "Open the diff for the selected entry" } },
                },


                file_history_panel = {
                    { "n", "<CR>",        actions.select_entry,        { desc = "Open the diff for the selected entry." } },
                },
			},
		})
	end,
}
