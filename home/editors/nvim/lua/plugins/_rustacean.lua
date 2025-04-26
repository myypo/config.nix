return {
	"mrcjkb/rustaceanvim",
	ft = { "rust" },
	config = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.rs",
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*.rs",
			callback = function()
				vim.cmd.RustLsp("flyCheck")
			end,
		})

		vim.g.rustaceanvim = {
			tools = { enable_clippy = false, hover_actions = { replace_builtin_hover = false } },
			dap = {
				adapter = require("rustaceanvim.config").get_codelldb_adapter(
					"@vscode-lldb@/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb",
					"@vscode-lldb@/share/vscode/extensions/vadimcn.vscode-lldb/lldb/lib/liblldb.so"
				),
			},
			server = {
				default_settings = {
					-- Options available here: https://github.com/rust-lang/rust-analyzer/blob/master/docs/book/src/configuration_generated.md
					["rust-analyzer"] = {
						checkOnSave = false,
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
						-- TODO: does not work as well?
						typing = { triggerChars = "=.<" },
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
