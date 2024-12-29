return {
	"mrcjkb/rustaceanvim",
	ft = { "rust" },
	config = function()
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
				on_attach = function(_, bufnr)
					local format_sync_grp = vim.api.nvim_create_augroup("RustaceanFormat", {})
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format()
						end,
						group = format_sync_grp,
					})
				end,
				default_settings = {
					-- Options available here: https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
					["rust-analyzer"] = {
						cargo = {
							buildScripts = {
								enable = true,
							},
							features = "all",
						},
						check = {
							command = "clippy",
							extraArgs = { "--no-deps" },
						},
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
								leptos_macro = { "server" },
							},
						},
					},
				},
			},
		}
	end,
}
