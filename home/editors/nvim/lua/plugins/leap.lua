return {
	"ggandor/leap.nvim",
	lazy = false,
	dependencies = {
		"tpope/vim-repeat",
		"ggandor/flit.nvim",
	},
	config = function()
		local leap = require("leap")
		leap.opts.safe_labels = "netsufm"
		leap.opts.labels = 'neitsroamgluypfwh,.dcx"/qz'
		leap.opts.case_sensitive = true

		vim.keymap.set({ "n", "v" }, "s", "<Plug>(leap)")

		vim.keymap.set({ "o" }, "s", function()
			require("leap.remote").action()
		end)

		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })

		vim.keymap.set({ "x", "o" }, "r", function()
			require("leap.treesitter").select()
		end)

		-- Prevent Visual mode flashes on using the treesiter function
		local saved_hls
		vim.api.nvim_create_autocmd("User", {
			pattern = "LeapEnter",
			callback = function()
				saved_hls = vim.api.nvim_get_hl(0, { name = "Visual" })
				vim.api.nvim_command("hi clear Visual")
			end,
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "LeapLeave",
			callback = function()
				vim.api.nvim_set_hl(0, "Visual", saved_hls)
			end,
		})

		require("flit").setup({ labeled_modes = "nvo", multiline = false })
	end,
}
