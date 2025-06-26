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
		leap.opts.labels = 'neitsroamgluypfwh,.dcx"/qzjkbv'
		leap.opts.preview_filter = function(ch0, ch1, ch2)
			return not (ch1:match("%s") or ch0:match("%w") and ch1:match("%w") and ch2:match("%w"))
		end

		vim.keymap.set({ "n" }, "s", "<Plug>(leap)")

		vim.keymap.set({ "o" }, "s", function()
			require("leap.remote").action()
		end)

		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })

		vim.keymap.set({ "o", "x" }, "r", function()
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
