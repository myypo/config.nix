return {
	"mrcjkb/rustaceanvim",
	ft = { "rust" },
	config = function()
		-- Workaround to ignore the ServerCancelled error
		-- https://github.com/neovim/neovim/issues/30985#issuecomment-2447329525
		for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
			local default_diagnostic_handler = vim.lsp.handlers[method]
			vim.lsp.handlers[method] = function(err, result, context, config)
				if err ~= nil and err.code == -32802 then
					return
				end
				return default_diagnostic_handler(err, result, context, config)
			end
		end

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.rs" },
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})

		vim.g.rustaceanvim = {
			dap = {
				adapter = require("rustaceanvim.config").get_codelldb_adapter(
					"@vscode-lldb@/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb",
					"@vscode-lldb@/share/vscode/extensions/vadimcn.vscode-lldb/lldb/lib/liblldb.so"
				),
			},
			server = {
				capabilities = vim.tbl_deep_extend(
					"force",
					vim.lsp.protocol.make_client_capabilities(),
					-- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
					require("cmp_nvim_lsp").default_capabilities(),
					{
						workspace = {
							didChangeWatchedFiles = { dynamicRegistration = false },
						},
					}
				),
				default_settings = {
					-- Options available here: https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
					["rust-analyzer"] = {
						cargo = {
							features = "all",
						},
						check = {
							-- Do not run clippy as it expands proc macros - berry slow...
							-- command = "clippy",
							features = "all",
						},
						diagnostics = {
							disabled = {
								"inactive-code",
								"proc-macros-disabled",
								"proc-macro-disabled",
								"unresolved-macro-call",
								"unresolved-proc-macro",
							},
						},
						procMacro = {
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
								leptos_macro = { "server" },
							},
						},
						-- TODO: rustfmt.toml + rust-analyzer.toml are just not caught by rust-analyzer for some reason
						rustfmt = {
							overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
						},
					},
				},
			},
		}
	end,
}
