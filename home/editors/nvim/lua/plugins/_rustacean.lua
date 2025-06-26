return {
	"mrcjkb/rustaceanvim",
	ft = { "rust" },
	config = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.rs",
			callback = function()
				vim.lsp.buf.format({ async = false })

				if vim.fn.executable("dx") == 0 then
					return
				end

				if vim.fn.executable("dx") == 1 then
					local path = vim.api.nvim_buf_get_name(0)
					if path == "" then
						return
					end

					local result = vim.system({ "dx", "fmt", "-f", path }, { text = true }):wait()
					if result.code == 0 then
						vim.cmd("silent! edit!")
					else
						vim.notify("dx fmt failed: " .. (result.stderr or ""), vim.log.levels.WARN)
					end
				end
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
						checkOnSave = true,

						cargo = {
							features = "all",
							targetDir = true,
						},
						check = {
							workspace = true,

							-- Do not run clippy as it expands proc macros - berry slow...
							-- command = "clippy",

							-- Breaks stuff?
							-- features = "all",
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
					},
				},
			},
		}
	end,
}
