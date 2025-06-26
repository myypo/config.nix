return {
	"LintaoAmons/scratch.nvim",
	cmd = { "Scratch", "ScratchOpen" },
	keys = {
		{ "<Leader>j", "<Cmd>ScratchOpenFzf<CR>" },
	},
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("scratch").setup({
			filetypes = { "md", "nu", "ts" },
			scratch_file_dir = "~/code/my/scratchpad/scratch.nvim",
			filetype_details = {
				["work.md"] = {
					subdir = "work",
				},
			},
			window_cmd = "edit",
			file_picker = "telescope",
		})
	end,
}
