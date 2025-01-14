return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
	},

	cmd = "Telescope",

	keys = {
		{ "<Leader>n", "<Cmd>Telescope find_files<CR>" },
		{ "<Leader>e", "<Cmd>Telescope live_grep<CR>" },
		{ "<Leader>g", "<Cmd>Telescope git_status<CR>" },
		{ "<Leader>r", "<Cmd>Telescope resume<CR>" },
		{ "<Leader>i", "<Cmd>Telescope diagnostics<CR>" },
		{ "<Leader>f", "<Cmd>lua require('telescope.builtin').registers()<CR>" },
		{ "rt", "<Cmd>Telescope lsp_definitions<CR>" },
		{ "rw", "<Cmd>Telescope lsp_definitions<CR><Cmd>vsplit<CR>" },
		{ "rs", "<Cmd>Telescope grep_string<CR>" },
		{ "ri", "<Cmd>Telescope lsp_implementations<CR>" },
		{
			"rr",
			function()
				require("telescope.builtin").lsp_references({ include_declaration = false })
			end,
		},
	},

	config = function()
		local status_ok, telescope = pcall(require, "telescope")
		if not status_ok then
			return
		end

		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					"go.mod",
					"go.sum",
					"^docs/",
					".ico",
				},

				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "smart" },
				color_devicons = true,
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
					width = 0.95,
					horizontal = {
						width_padding = 0.04,
						height_padding = 0.1,
						preview_width = 0.70,
					},
					vertical = {
						width_padding = 0.05,
						height_padding = 1,
						preview_height = 0.5,
					},
				},

				default_mappings = {
					i = {
						["<CR>"] = actions.select_default,
						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,
						["<C-n>"] = actions.cycle_history_prev,
						["<C-e>"] = actions.cycle_history_next,
						["<C-w>"] = actions.select_vertical,
						["<PageDown>"] = actions.preview_scrolling_down,
						["<PageUp>"] = actions.preview_scrolling_up,
						["<C-t>"] = actions.close,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
					n = {
						["<CR>"] = actions.select_default,
						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,
						["<C-n>"] = actions.cycle_history_prev,
						["<C-e>"] = actions.cycle_history_next,
						["<Leader>w"] = actions.select_vertical,
						["<PageDown>"] = actions.preview_scrolling_down,
						["<PageUp>"] = actions.preview_scrolling_up,
						["<Leader>t"] = actions.close,
						["<Leader>q"] = actions.smart_send_to_qflist + actions.open_qflist,

						["gg"] = actions.move_to_top,
						["G"] = actions.move_to_bottom,
					},
				},
			},
			pickers = {
				diagnostics = {
					root_dir = true,
					sort_by = "severity",
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		require("telescope").load_extension("fzf")
	end,
}
