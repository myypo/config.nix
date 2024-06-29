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
				capabilities = {
					textDocument = {
						completion = {
							completionItem = {
								snippetSupport = false,
							},
						},
					},
				},
				settings = {
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
							},
						},
					},
				},
			},
		}
	end,
}
