return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local nvim_lsp = require("lspconfig")

		vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, _)
			if vim.bo.readonly then
				return
			end

			-- Do not publish diagnostics under home directories with name starting with dot and in node_modules
			local buf = vim.api.nvim_buf_get_name(0)
			if buf:match("/home/[^/]*/%.[^/]*/") or buf:match(".*/node_modules/.*") then
				return
			end

			vim.lsp.diagnostic.on_publish_diagnostics(nil, result, ctx)
		end

		vim.diagnostic.config({
			virtual_text = false,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = " ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
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

		Keymap("n", ")", function()
			vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = false })
		end)
		Keymap("n", "(", function()
			vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = false })
		end)

		Keymap("n", "}", function()
			vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN, float = false })
		end)
		Keymap("n", "{", function()
			vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN, float = false })
		end)

		Keymap("n", "]", function()
			vim.diagnostic.jump({
				count = -1,
				severity = { vim.diagnostic.severity.HINT, vim.diagnostic.severity.INFO },
				float = false,
			})
		end)
		Keymap("n", "[", function()
			vim.diagnostic.jump({
				count = 1,
				severity = { vim.diagnostic.severity.HINT, vim.diagnostic.severity.INFO },
				float = false,
			})
		end)

		Keymap("n", "<C-m>", function()
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

		Keymap("n", "lr", vim.lsp.buf.rename)

		Keymap("n", "<Leader>a", function()
			vim.lsp.buf.code_action({ apply = true })
		end)

		Keymap("n", "R", function()
			vim.lsp.buf.hover()
		end)

		local capabilities = vim.lsp.protocol.make_client_capabilities()

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

		-- nvim_lsp.postgres_lsp.setup({ capabilities = capabilities })

		-- nvim_lsp.bacon_ls.setup({
		-- 	capabilities = capabilities,
		-- 	cmd = { "bacon-ls" },
		-- 	init_options = {
		-- 		updateOnSave = true,
		-- 		updateOnSaveWaitMillis = 200,
		-- 		runBaconInBackground = false,
		-- 		synchronizeAllOpenFilesWaitMillis = 1000,
		--
		-- 		-- BETA:
		-- 		useCargoBackend = true,
		-- 		cargoEnv = "CARGO_TARGET_DIR=.checkTarget",
		-- 		cargoCommandArguments = "check --workspace --tests --all-targets --all-features --message-format json-diagnostic-rendered-ansi",
		--
		-- 		-- This copies the entire source tree to a temporary directory, and will
		-- 		-- therefore not work for most cases.
		-- 		updateOnChange = false,
		-- 		updateOnChangeCooldownMillis = 5000,
		-- 	},
		-- })

		nvim_lsp.roc_ls.setup({ capabilities = capabilities })

		nvim_lsp.hls.setup({ capabilities = capabilities })

		nvim_lsp.ccls.setup({ capabilities = capabilities })

		nvim_lsp.tailwindcss.setup({
			capabilities = capabilities,
			root_dir = nvim_lsp.util.root_pattern("tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs"),
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

		nvim_lsp.golangci_lint_ls.setup({
			capabilities = capabilities,
		})

		-- nvim_lsp.terraformls.setup({
		-- 	capabilities = capabilities,
		-- })
	end,
}
