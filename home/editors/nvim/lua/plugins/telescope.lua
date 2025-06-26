return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
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

		-- NOTE: If you try to use this before entering any input, an error is thrown.
		-- (Help would be appreciated, if someone knows a fix.)
		local function get_targets(buf)
			local pick = require("telescope.actions.state").get_current_picker(buf)
			local scroller = require("telescope.pickers.scroller")
			local wininfo = vim.fn.getwininfo(pick.results_win)[1]
			local top = math.max(
				scroller.top(pick.sorting_strategy, pick.max_results, pick.manager:num_results()),
				wininfo.topline - 1
			)
			local bottom = wininfo.botline - 2 -- skip the current row
			local targets = {}
			for lnum = bottom, top, -1 do -- start labeling from the closest (bottom) row
				table.insert(targets, { wininfo = wininfo, pos = { lnum + 1, 1 }, pick = pick })
			end
			return targets
		end
		local function pick_with_leap(buf)
			require("leap").leap({
				targets = function()
					return get_targets(buf)
				end,
				action = function(target)
					target.pick:set_selection(target.pos[1] - 1)
					require("telescope.actions").select_default(buf)
				end,
			})
		end

		-- FIXME: https://github.com/nvim-telescope/telescope.nvim/issues/3436
		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopeFindPre",
			callback = function()
				vim.opt_local.winborder = "none"
				vim.api.nvim_create_autocmd("WinLeave", {
					once = true,
					callback = function()
						vim.opt_local.winborder = "rounded"
					end,
				})
			end,
		})

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
						["<C-s>"] = pick_with_leap,
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
						["s"] = pick_with_leap,
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
