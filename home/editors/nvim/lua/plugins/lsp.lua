return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local nvim_lsp = require("lspconfig")
		local keymap = vim.keymap.set

		local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		local float_opts = {
			focusable = false,
			close_events = {
				"BufLeave",
				"CursorMoved",
				"InsertEnter",
				"BufHidden",
				"WinLeave",
			},
			border = "rounded",
			source = false,
			prefix = " ",
			suffix = " ",
			header = " Diagnostics:",
			scope = "line",
		}
		vim.diagnostic.config({
			virtual_text = false,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = float_opts,
		})

		-- Allows toggling diagnostics floats on ESC
		keymap("n", "<Esc>", function()
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				if vim.api.nvim_win_get_config(win).relative ~= "" then
					vim.api.nvim_win_close(win, true)
					return
				end
			end

			vim.diagnostic.open_float(nil)
		end, { noremap = true, silent = true })

		keymap(
			{ "n", "v" },
			")",
			"<Cmd>lua vim.diagnostic.goto_prev({ severity =  vim.diagnostic.severity.ERROR, float = false })<CR>",
			{ noremap = true, silent = true }
		)
		keymap(
			{ "n", "v" },
			"(",
			"<Cmd>lua vim.diagnostic.goto_next({ severity =  vim.diagnostic.severity.ERROR, float = false })<CR>",
			{ noremap = true, silent = true }
		)

		keymap(
			{ "n", "v" },
			"}",
			"<Cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN, float = false })<CR>",
			{ noremap = true, silent = true }
		)
		keymap(
			{ "n", "v" },
			"{",
			"<Cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN, float = false })<CR>",
			{ noremap = true, silent = true }
		)

		keymap(
			{ "n", "v" },
			"]",
			"<Cmd>lua vim.diagnostic.goto_prev({ severity = { vim.diagnostic.severity.HINT, vim.diagnostic.severity.INFO }, float = false })<CR>",
			{ noremap = true, silent = true }
		)
		keymap(
			{ "n", "v" },
			"[",
			"<Cmd>lua vim.diagnostic.goto_next({ severity = { vim.diagnostic.severity.HINT, vim.diagnostic.severity.INFO }, float = false })<CR>",
			{ noremap = true, silent = true }
		)

		keymap({ "n", "v" }, "<C-m>", function()
			local dlist = vim.diagnostic.get(nil, { severity = { vim.diagnostic.severity.ERROR } })
			if #dlist < 1 then
				return
			end

			local d = dlist[1]
			vim.api.nvim_set_current_buf(d.bufnr)
			vim.api.nvim_win_set_cursor(0, { d.end_lnum + 1, d.end_col })
		end, { noremap = true, silent = true })

		-- LSP setups
		nvim_lsp.nil_ls.setup({})

		nvim_lsp.gopls.setup({
			settings = {
				gopls = {
					experimentalPostfixCompletions = true,
					analyses = {
						unusedparams = true,
						shadow = true,
					},
					staticcheck = true,
					semanticTokens = true,
				},
			},
			init_options = {
				usePlaceholders = true,
			},

			-- HACK: because experiencing issues with diagnostics never dissapearing
			flags = {
				allow_incremental_sync = false,
			},
		})

		nvim_lsp.pyright.setup({
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						useLibraryCodeForTypes = true,
						typeCheckingMode = "off",
					},
				},
			},
		})

		nvim_lsp.html.setup({
			cmd = { "vscode-html-language-server", "--stdio" },
		})

		nvim_lsp.cssls.setup({
			cmd = { "vscode-css-language-server", "--stdio" },
		})

		nvim_lsp.bashls.setup({
			cmd = { "bash-language-server", "start" },
		})

		nvim_lsp.sqls.setup({
			on_attach = function(client, _)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
		})

		nvim_lsp.roc_ls.setup({})

		nvim_lsp.hls.setup({})

		nvim_lsp.ccls.setup({})
	end,
}
