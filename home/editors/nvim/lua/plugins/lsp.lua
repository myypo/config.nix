return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local nvim_lsp = require("lspconfig")
		local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		vim.diagnostic.config({
			virtual_text = false,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
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
			},
		})

		-- Allows toggling diagnostics floats on ESC
		Keymap("n", "<Esc>", function()
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				if vim.api.nvim_win_get_config(win).relative ~= "" then
					vim.api.nvim_win_close(win, true)
					return
				end
			end

			vim.diagnostic.open_float(nil)
		end)

		Keymap({ "n", "v" }, ")", function()
			vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR, float = false })
		end)
		Keymap({ "n", "v" }, "(", function()
			vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, float = false })
		end)

		Keymap({ "n", "v" }, "}", function()
			vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN, float = false })
		end)
		Keymap({ "n", "v" }, "{", function()
			vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN, float = false })
		end)

		Keymap({ "n", "v" }, "]", function()
			vim.diagnostic.goto_prev({
				severity = { vim.diagnostic.severity.HINT, vim.diagnostic.severity.INFO },
				float = false,
			})
		end)
		Keymap({ "n", "v" }, "[", function()
			vim.diagnostic.goto_next({
				severity = { vim.diagnostic.severity.HINT, vim.diagnostic.severity.INFO },
				float = false,
			})
		end)

		Keymap({ "n", "v" }, "<C-m>", function()
			local dlist = vim.diagnostic.get(nil, { severity = { vim.diagnostic.severity.ERROR } })
			if #dlist == 0 then
				return
			end

			local d = dlist[1]
			vim.api.nvim_set_current_buf(d.bufnr)
			vim.api.nvim_win_set_cursor(0, { d.end_lnum + 1, d.end_col })
		end)

		Keymap({ "n", "v" }, "lr", vim.lsp.buf.rename)

		Keymap({ "n", "v" }, "<Leader>a", function()
			vim.lsp.buf.code_action({ apply = true })
		end)

		-- LSP setups
		nvim_lsp.nil_ls.setup({})

		nvim_lsp.lua_ls.setup({
			settings = {
				Lua = {
					semantic = {
						enable = false,
					},
					format = {
						enable = false,
					},
				},
			},
		})

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

			-- HACK: because experiencing issues with diagnostics never disappearing
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

		nvim_lsp.eslint.setup({
			capabilities = {
				document_formatting = false,
				document_range_formatting = false,
			},

			settings = {
				rulesCustomizations = {
					-- Might conflict with prettier
					{ rule = "@typescript-eslint/no-misused-promises", severity = "off" },
					{ rule = "@typescript-eslint/no-unsafe-argument", severity = "off" },
					{ rule = "@typescript-eslint/no-unsafe-assignment", severity = "off" },
					{ rule = "import/defaults", severity = "off" },
					{ rule = "import/extensions", severity = "off" },
					{ rule = "import/namespace", severity = "off" },
					{ rule = "import/no-cycle", severity = "off" },
					{ rule = "import/no-unresolved", severity = "off" },

					-- Disable some rules that conflight with tsserver warnings
					{ rule = "*no-unused-vars", severity = "off" },
				},
			},
		})

		nvim_lsp.typos_lsp.setup({
			init_options = {
				diagnosticSeverity = "Info",

				config = "~/.config/typos.toml",
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

		nvim_lsp.nushell.setup({})

		nvim_lsp.sqls.setup({
			on_attach = function(client, _)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
		})

		nvim_lsp.roc_ls.setup({})

		nvim_lsp.hls.setup({})

		nvim_lsp.ccls.setup({})

		nvim_lsp.tailwindcss.setup({
			root_dir = nvim_lsp.util.root_pattern("tailwind.config.js", "tailwind.config.ts"),
		})

		nvim_lsp.rescriptls.setup({
			on_attach = function(client, _)
				client.server_capabilities.semanticTokensProvider = nil
			end,
		})

		vim.filetype.add({ extension = { purs = "purescript" } })
		nvim_lsp.purescriptls.setup({
			root_dir = nvim_lsp.util.root_pattern("spago.dhall"),
			settings = {
				purescript = {
					addSpagoSources = true,
				},
			},
		})
	end,
}
