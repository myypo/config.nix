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

		vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
			if vim.bo.readonly then
				return
			end

			-- Do not publish diagnostics under home directories with name starting with dot and in node_modules
			local buf = vim.api.nvim_buf_get_name(0)
			if buf:match("/home/[^/]*/%.[^/]*/") or buf:match(".*/node_modules/.*") then
				return
			end

			vim.lsp.diagnostic.on_publish_diagnostics(nil, result, ctx, config)
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

		-- Allows toggling diagnostics floats on Enter
		Keymap("n", "<CR>", function()
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

			local curr_buf = vim.api.nvim_get_current_buf()
			local target_idx = 1
			local found_next = false
			for i, v in ipairs(dlist) do
				if v.bufnr == curr_buf then
					found_next = true
					goto continue
				end

				if found_next then
					target_idx = i
					break
				end

				::continue::
			end

			local d = dlist[target_idx]
			vim.api.nvim_set_current_buf(d.bufnr)
			vim.api.nvim_win_set_cursor(0, { d.end_lnum + 1, d.end_col })
		end)

		Keymap({ "n", "v" }, "lr", vim.lsp.buf.rename)

		Keymap({ "n", "v" }, "<Leader>a", function()
			vim.lsp.buf.code_action({ apply = true })
		end)

		-- LSP setups
		-- client capabilities (+ the completion ones from nvim-cmp).
		local client_capabilities = function()
			return vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				-- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
				require("cmp_nvim_lsp").default_capabilities(),
				{
					workspace = {
						didChangeWatchedFiles = { dynamicRegistration = false },
					},
				}
			)
		end
		local capabilities = client_capabilities()

		nvim_lsp.nil_ls.setup({ capabilities = capabilities })

		nvim_lsp.lua_ls.setup({
			capabilities = capabilities,
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
			capabilities = capabilities,
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
			capabilities = capabilities,
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
			capabilities = vim.tbl_deep_extend(
				"force",
				capabilities,
				{ document_formatting = false, document_range_formatting = false }
			),

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
			capabilities = capabilities,
			init_options = {
				diagnosticSeverity = "Info",

				config = "~/.config/typos.toml",
			},
		})

		nvim_lsp.html.setup({
			capabilities = capabilities,
			cmd = { "vscode-html-language-server", "--stdio" },
		})

		nvim_lsp.cssls.setup({
			capabilities = capabilities,
			cmd = { "vscode-css-language-server", "--stdio" },
		})

		nvim_lsp.bashls.setup({
			capabilities = capabilities,
			cmd = { "bash-language-server", "start" },
		})

		nvim_lsp.nushell.setup({ capabilities = capabilities })

		require("lspconfig.configs").postgres_lsp = {
			default_config = {
				name = "postgres_lsp",
				cmd = { "postgres_lsp" },
				filetypes = { "sql" },
				single_file_support = true,
			},
		}
		nvim_lsp.postgres_lsp.setup({
			capabilities = capabilities,
			force_setup = true,
		})

		nvim_lsp.roc_ls.setup({ capabilities = capabilities })

		nvim_lsp.hls.setup({ capabilities = capabilities })

		nvim_lsp.ccls.setup({ capabilities = capabilities })

		nvim_lsp.tailwindcss.setup({
			capabilities = capabilities,
			root_dir = nvim_lsp.util.root_pattern("tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs"),
		})

		nvim_lsp.rescriptls.setup({
			capabilities = capabilities,
			on_attach = function(client, _)
				client.server_capabilities.semanticTokensProvider = nil
			end,
		})

		vim.filetype.add({ extension = { purs = "purescript" } })
		nvim_lsp.purescriptls.setup({
			capabilities = capabilities,
			root_dir = nvim_lsp.util.root_pattern("spago.dhall"),
			settings = {
				purescript = {
					addSpagoSources = true,
				},
			},
		})

		nvim_lsp.taplo.setup({
			capabilities = capabilities,
			on_attach = function()
				vim.api.nvim_create_autocmd("BufWritePre", {
					pattern = { "*.toml" },
					callback = function()
						vim.lsp.buf.format({ async = false })
					end,
				})
			end,
			workspace_config = {
				formatter = {
					reorderKeys = true,
				},
			},
		})
	end,
}
