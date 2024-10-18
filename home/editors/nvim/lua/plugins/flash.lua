return {
	"myypo/flash.nvim",

	branch = "master",

	keys = {
		"f",
		"F",
		{
			"s",
			mode = { "n" },
			function()
				require("flash").jump()
			end,
		},

		{
			"r",
			mode = { "o" },
			function()
				require("flash").treesitter_search()
			end,
		},

		{
			"R",
			mode = { "o" },
			function()
				require("flash").treesitter()
			end,
		},
	},

	config = function()
		require("flash").setup({
			-- Colemak-DH optimization
			labels = "arstgmneiowfpluyxcdh,.qbj'zvk/",
			jump = {
				autojump = true,
			},
			search = {
				enabled = false,
				multi_window = false,
			},
			prompt = { enabled = false },
			highlight = { matches = false },
			modes = {
				treesitter_search = {
					search = { multi_window = false, wrap = true, incremental = false },
				},
				treesitter = { highlight = { backdrop = true } },
				char = {
					config = function(opts)
						opts.autohide = opts.autohide or (vim.fn.mode(true):find("no") and vim.v.operator == "y")
						opts.jump_labels = opts.jump_labels
							and vim.v.count == 0
							and vim.fn.reg_executing() == ""
							and vim.fn.reg_recording() == ""
					end,
					label = { exclude = "raidc" },
					enabled = true,
					multi_line = false,
					autohide = true,
					highlight = { backdrop = true },
					jump_labels = true,
					jump = { autojump = true },
				},
				search = { enabled = false },
			},
		})
	end,
}
