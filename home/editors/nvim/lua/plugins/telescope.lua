return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
		{
			"nvim-telescope/telescope-ui-select.nvim",
			init = function()
				vim.ui.select = function(...)
					require("lazy").load({ plugins = { "telescope.nvim" } })
					vim.ui.select(...)
				end
			end,
		},
	},

	cmd = "Telescope",

    -- stylua: ignore
	keys = {
		{ "rt", "<Cmd>Telescope lsp_definitions<CR>", desc = "Telescope lsp definitons" },
		{ "rw", "<Cmd>Telescope lsp_definitions<CR><Cmd>vsplit<CR>", desc = "Telescope lsp definiton in a new window" },
		{ "rs", "<Cmd>Telescope grep_string<CR>", desc = "Telescope grep under cursor" },
		{ "ri", "<Cmd>Telescope lsp_implementations<CR>", desc = "Telescope lsp impls" },
		{ "rr", "<Cmd>Telescope lsp_references<CR>", desc = "Telescope lsp references" },
		{ "<Leader>n", "<Cmd>Telescope find_files<CR>", desc = "Telescope find files" },
		{ "<Leader>e", "<Cmd>Telescope live_grep<CR>", desc = "Telescope grep" },
		{ "<Leader>a", "<Cmd>lua vim.lsp.buf.code_action({ apply = true })<CR>", desc = "Telescope code action UI" },
		{ "<Leader>g", "<Cmd>Telescope git_status<CR>", desc = "Telescope git changes" },
		{ "<Leader>r", "<Cmd>Telescope resume<CR>", desc = "Telescope resume last aciton" },
		{ "<Leader>o", "<Cmd>lua require('telescope.builtin').diagnostics({root_dir=true})<CR>", desc = "Telescope diagnostics" },
		{ "<Leader>p", "<Cmd>lua require('telescope.builtin').registers()<CR>", desc = "Telescope registers" },
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

				mappings = {
					i = {
						["<C-i>"] = actions.cycle_history_next,
						["<C-o>"] = actions.cycle_history_prev,

						["<C-a>"] = actions.close,

						["<C-w>"] = actions.select_vertical,
					},
					n = {
						["<C-i>"] = actions.cycle_history_next,
						["<C-o>"] = actions.cycle_history_prev,

						["<C-w>"] = actions.select_vertical,

						["<C-a>"] = actions.close,
					},
				},
			},
			pickers = {
				diagnostics = {
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

				["ui-select"] = {
					require("telescope.themes").get_cursor({}),
				},
			},
		})

		require("telescope").load_extension("fzf")

		require("telescope").load_extension("ui-select")
	end,
}
